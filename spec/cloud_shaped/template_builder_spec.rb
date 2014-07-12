require 'spec_helper'

require 'cloud_shaped/template_builder'

describe CloudShaped::TemplateBuilder do

  def self.define_template_builder(&block)
    let(:template_builder_class) do
      Class.new(CloudShaped::TemplateBuilder, &block)
    end
  end

  context "with an empty #build method" do

    define_template_builder do

      def build
      end

    end

    it "builds an empty template" do
      empty_template = {
        "AWSTemplateFormatVersion" => '2010-09-09',
        "Parameters" => {},
        "Resources" => {},
        "Outputs" => {}
      }
      expect(template_builder_class.build).to eq(empty_template)
    end

  end

  context "with resources defined" do

    define_template_builder do

      def build
        resources["fooBar"] = resource("AWS::Foo::Bar", "foo" => "bar")
      end

    end

    it "includes the resources" do
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

end
