require 'cloud_shaped/dsl'

module CloudShaped

  # A base class to aid programmatic generation of CloudFormation templates.
  #
  # The operative method is "#generate", which should return CloudFormation template
  # data, suitable for serialisation in JSON.
  #
  #
  class Template

    def self.generate(*args)
      new(*args).generate
    end

    def generate
      {
        "AWSTemplateFormatVersion" => '2010-09-09',
        "Parameters" => parameters,
        "Resources" => resources,
        "Outputs" => outputs
      }
    end

    def parameters
      {}
    end

    # Define in sub-classes:
    #
    #   def resources
    #     ...
    #   end

    def outputs
      {}
    end

    include CloudShaped::DSL

  end

end

