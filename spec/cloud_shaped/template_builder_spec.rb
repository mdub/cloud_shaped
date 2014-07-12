require 'spec_helper'

require 'cloud_shaped/template_builder'

describe CloudShaped::TemplateBuilder do

  it "builds CloudFormation templates" do

    template_builder_class = Class.new(CloudShaped::TemplateBuilder) do

      def build
      end

    end

    empty_template = {
      "AWSTemplateFormatVersion" => '2010-09-09',
      "Parameters" => {},
      "Resources" => {},
      "Outputs" => {}
    }

    expect(template_builder_class.build).to eq(empty_template)

  end

  it "supports resources" do

    template_builder_class = Class.new(CloudShaped::TemplateBuilder) do

      def build
        resources["fooBar"] = resource("AWS::Foo::Bar", "foo" => "bar")
      end

    end

    template_with_elb = {
      "AWSTemplateFormatVersion" => '2010-09-09',
      "Parameters" => {},
      "Resources" => {
        "fooBar" => {
          "Type" => "AWS::Foo::Bar",
          "Properties" => {"foo" => "bar"}
        }
      },
      "Outputs" => {}
    }

    expect(template_builder_class.build).to eq(template_with_elb)

  end

end
