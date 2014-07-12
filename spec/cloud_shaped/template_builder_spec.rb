require 'spec_helper'

require 'cloud_shaped/template_builder'

describe CloudShaped::TemplateBuilder do

  it "builds CloudFormation templates" do

    template = CloudShaped::TemplateBuilder.build do
    end

    expect(template).to eq(
    {
      "AWSTemplateFormatVersion" => '2010-09-09',
      "Parameters" => {},
      "Resources" => {},
      "Outputs" => {}
    }
    )

  end

  it "supports resources" do

    template = CloudShaped::TemplateBuilder.build do |builder|
      builder.def_resource "fooBar", "AWS::Foo::Bar", "foo" => "bar"
    end

    expect(template).to eq(
    {
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
    )

  end

end
