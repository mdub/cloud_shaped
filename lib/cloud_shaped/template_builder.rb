require 'cloud_shaped/dsl'

module CloudShaped

  # A TemplateBuilder is an object that can generate a CloudFormation template,
  # in the form of Ruby data.
  #
  class TemplateBuilder

    def self.build
      builder = new
      yield builder if block_given?
      builder.template
    end

    def initialize(settings = {})
      @parameters = {}
      @resources = {}
      @outputs = {}
    end

    attr_reader :parameters
    attr_reader :resources
    attr_reader :outputs

    def template
      {
        "AWSTemplateFormatVersion" => '2010-09-09',
        "Parameters" => parameters,
        "Resources" => resources,
        "Outputs" => outputs
      }
    end

    include CloudShaped::DSL

    def def_parameter(name, *args)
      parameters[name] = parameter(*args)
    end

    def def_resource(name, type, *args)
      resources[name] = resource(type, *args)
    end

    def def_output(name, *args)
      outputs[name] = output(*args)
    end

  end

end
