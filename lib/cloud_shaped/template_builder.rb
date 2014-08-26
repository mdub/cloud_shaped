require 'cloud_shaped/dsl'

module CloudShaped
  # A {http://en.wikipedia.org/wiki/Builder_pattern builder} for CloudFormation
  # templates.
  class TemplateBuilder
    def initialize(_settings = {})
      @parameters = {}
      @resources = {}
      @outputs = {}
    end

    # @return [Hash] a CloudFormation template as Ruby data
    #
    def template
      {
        'AWSTemplateFormatVersion' => '2010-09-09',
        'Parameters' => parameters,
        'Resources' => resources,
        'Outputs' => outputs
      }
    end

    include CloudShaped::DSL

    # Declares a Parameter.
    #
    # @param name [String] the parameter name
    # @option options [String] :type ("String") the parameter type
    # @option options [String] :description parameter description
    # @option options [String] :default a default value
    #
    # @example
    #   def_parameter "appName"
    #   def_parameter "minInstances", :type => "Number"
    #
    def def_parameter(name, options = {})
      parameters[name] = parameter(options)
    end

    # Declares a Resource.
    #
    # @param name [String] the resource name
    # @param type [String, Symbol] the resource type
    # @param args [Hash] resource properties
    #
    def def_resource(name, type, *args, &block)
      resources[name] = if type.is_a?(Symbol)
                          send(type, *args, &block)
                        else
                          resource(type, *args, &block)
                        end
      resources.reject! { |_k, v| v.nil? }
    end

    # Declares an Output.
    #
    # @param name [String] the output name
    # @param value the output value (usually a reference to a resource)
    #
    # @example
    #   def_output "loadBalancerName", ref("loadBalancer")
    #
    def def_output(name, value)
      outputs[name] = output(value)
    end

    protected

    attr_reader :parameters
    attr_reader :resources
    attr_reader :outputs
  end
end
