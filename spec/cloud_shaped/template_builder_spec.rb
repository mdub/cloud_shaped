require 'spec_helper'

require 'cloud_shaped/template_builder'

describe CloudShaped::TemplateBuilder do

  subject(:template_builder) { described_class.new }

  let(:template) { template_builder.template }

  describe "#template" do

    it "returns a CloudFormation template" do

      expect(template).to eq(
      {
        "AWSTemplateFormatVersion" => '2010-09-09',
        "Parameters" => {},
        "Resources" => {},
        "Outputs" => {}
      }
      )

    end

  end

  describe "#def_resource" do

    before do
      template_builder.def_resource "fooBar", "AWS::Foo::Bar", "foo" => "bar"
    end

    it "defines a Resource" do

      expect(template["Resources"]).to eq(
      {
        "fooBar" => {
          "Type" => "AWS::Foo::Bar",
          "Properties" => {"foo" => "bar"}
        }
      }
      )

    end

  end

end
