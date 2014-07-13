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
      @resources = {}
      @outputs = {}
    end

    attr_reader :resources
    attr_reader :outputs

    def template
      {
        "AWSTemplateFormatVersion" => '2010-09-09',
        "Parameters" => {},
        "Resources" => resources,
        "Outputs" => outputs
      }
    end

    include CloudShaped::DSL

    def def_resource(name, type, properties)
      resources[name] = resource(type, properties)
    end

    def def_output(name, value)
      outputs[name] = output(value)
    end

  end

end
