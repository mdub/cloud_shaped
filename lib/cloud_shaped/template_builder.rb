require 'cloud_shaped/dsl'

module CloudShaped

  # A TemplateBuilder is an object that can generate a CloudFormation template,
  # in the form of Ruby data.
  #
  class TemplateBuilder

    def self.build(*args)
      new(*args).tap do |builder|
        builder.build
      end.template
    end

    def initialize(settings = {})
      @resources = {}
    end

    attr_reader :resources

    def template
      {
        "AWSTemplateFormatVersion" => '2010-09-09',
        "Parameters" => {},
        "Resources" => resources,
        "Outputs" => {}
      }
    end

    include CloudShaped::DSL

  end

end
