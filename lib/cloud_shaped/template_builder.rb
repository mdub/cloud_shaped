# frozen_string_literal: true

require "cloud_shaped/dsl"

module CloudShaped

  # A {http://en.wikipedia.org/wiki/Builder_pattern builder} for CloudFormation templates.
  #
  class TemplateBuilder

    def initialize
      @metadata = {}
      @parameters = {}
      @mappings = {}
      @conditions = {}
      @resources = {}
      @outputs = {}
    end

    # @return [Hash] a CloudFormation template as Ruby data
    #
    def template
      {}.tap do |template|
        template["AWSTemplateFormatVersion"] = "2010-09-09"
        template["Description"] = description if description
        template["Metadata"] = metadata unless metadata.empty?
        template["Parameters"] = parameters unless parameters.empty?
        template["Mappings"] = mappings unless mappings.empty?
        template["Conditions"] = conditions unless conditions.empty?
        template["Resources"] = resources
        template["Outputs"] = outputs unless outputs.empty?
      end
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
      yield options if block_given?
      parameters[name] = parameter(options)
    end

    # Declares a Mappping.
    #
    # @param name [String] the mapping name
    # @param mapping [Hash] the mapping
    #
    # @example
    #   def_mapping "regionMap", "us-east-1" => { "32" => "ami-6411e20d" }
    #
    def def_mapping(name, mapping = {})
      yield mapping if block_given?
      mappings[name] = mapping
    end

    # Declares a Condition.
    #
    # @param name [String] the condition name
    # @param condition [Hash] the condition body
    #
    # @example
    #   def_mapping "inProd", fn_equals(ref("Env"), "prod")
    #
    def def_condition(name, body)
      conditions[name] = body
    end

    # Declares a Resource.
    #
    # @param name [String] the resource name
    # @param type [String, Symbol] the resource type
    # @param args [Hash] resource properties
    #
    def def_resource(name, type, *args, &block)
      definition = if type.is_a?(Symbol)
                     send(type, *args, &block)
                   else
                     resource(type, *args, &block)
                   end
      resources[name] = definition if definition
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

    attr_accessor :description
    attr_reader :metadata

    protected

    attr_reader :parameters
    attr_reader :mappings
    attr_reader :conditions
    attr_reader :resources
    attr_reader :outputs

  end

end
