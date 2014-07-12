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

    end

    def template
      {
        "AWSTemplateFormatVersion" => '2010-09-09',
        "Parameters" => {},
        "Resources" => {},
        "Outputs" => {}
      }
    end

  end

end
