require "cloud_shaped/core_methods"
require "cloud_shaped/function_methods"

module CloudShaped

  module Interpolation

    include CoreMethods
    include FunctionMethods

    DEFAULT_DELIMITERS = ["{{", "}}"].freeze

    # Interpolates a String, inserting calls to "Ref" and "Fn::GetAtt".
    #
    # @param string [String] input string
    # @param delimiters [Array] opening and closing delimter
    #
    def interpolate(string, delimiters = DEFAULT_DELIMITERS)
      interpolated_lines = string.split("\n", -1).map do |line|
        interpolate_line(line, delimiters)
      end
      join("\n", interpolated_lines)
    end

    private

    def interpolate_line(line, delimiters)
      open, close = delimiters
      tokens = line.split(/(#{Regexp.quote(open)}[\w:.]+#{Regexp.quote(close)})/)
      tokens.reject!(&:empty?)
      fragments = tokens.map do |token|
        if token =~ /^#{Regexp.quote(open)}([\w:]+)(?:\.(\w+))?#{Regexp.quote(close)}$/
          ref(Regexp.last_match(1), Regexp.last_match(2))
        else
          token
        end
      end
      join("", fragments)
    end

    def join(delimiter, parts)
      return "" if parts.empty?
      return parts.first if parts.one?
      fn_join(delimiter, parts)
    end

  end

end
