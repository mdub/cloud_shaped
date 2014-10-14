require 'cloud_shaped/core_methods'
require 'cloud_shaped/function_methods'

module CloudShaped

  module Interpolation

    include CoreMethods
    include FunctionMethods

    DEFAULT_DELIMITERS =['{{','}}']

    # Interpolates a String, inserting calls to "Ref" and "Fn::GetAtt".
    #
    # @param string [String] input string
    # @param delimiters [Array] opening and closing delimter
    #
    def interpolate(string, delimiters = DEFAULT_DELIMITERS)
      fragments = string.lines.map do |line|
        interpolate_line(line, delimiters)
      end.flatten
      fn_join('', fragments)
    end

    private

    def interpolate_line(line, delimiters)
      open, close = delimiters
      tokens = line.split(/(#{Regexp.quote(open)}[\w:]+#{Regexp.quote(close)})/)
      tokens.reject!(&:empty?)
      tokens.map do |token|
        if token =~ /^#{Regexp.quote(open)}([\w:]+)(?:\.(\w+))?#{Regexp.quote(close)}$/
          ref($1, $2)
        else
          token
        end
      end
    end

  end

end
