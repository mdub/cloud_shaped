require "spec_helper"

require "cloud_shaped/template_builder"

describe CloudShaped::TemplateBuilder do

  subject(:template_builder) { described_class.new }

  let(:template) { template_builder.template }

  describe "#template" do

    it "returns a CloudFormation template" do

      expect(template).to eq(
        "AWSTemplateFormatVersion" => "2010-09-09",
        "Resources" => {}
      )

    end

  end

  describe "#description=" do

    it "sets the Description" do
      template_builder.description = "My awesome template"
      expect(template["Description"]).to eq("My awesome template")
    end

  end

  describe "#def_resource" do

    it "defines a Resource" do

      template_builder.def_resource("fooBar", "AWS::Foo::Bar", "foo" => "bar")

      expect(template["Resources"]).to eq(
        "fooBar" => {
          "Type" => "AWS::Foo::Bar",
          "Properties" => { "foo" => "bar" }
        }
      )

    end

    context "with a symbol as the second argument" do

      before do
        def template_builder.fnord(size)
          resource "AWS::Fnord::Fnord", "Size" => size
        end
      end

      it "calls the method named by the symbol to define the resource" do

        template_builder.def_resource("fooBar", :fnord, "3")

        expect(template["Resources"]).to eq(
          "fooBar" => {
            "Type" => "AWS::Fnord::Fnord",
            "Properties" => { "Size" => "3" }
          }
        )

      end

    end

    context "when resource macro-method returns nil" do

      before do
        def template_builder.nada(*_args)
          nil
        end
      end

      it "does not define a resource" do

        template_builder.def_resource("fooBar", :nada)

        expect(template["Resources"]).to be_empty

      end

    end

  end

  describe "#def_parameter" do

    before do
      template_builder.def_parameter("size")
    end

    it "defines a Parameter" do

      expect(template["Parameters"]).to eq(
        "size" => {
          "Type" => "String"
        }
      )

    end

  end

  describe "#def_output" do

    before do
      template_builder.def_output("myName", "bob")
    end

    it "defines an Output" do

      expect(template["Outputs"]).to eq(
        "myName" => {
          "Value" => "bob"
        }
      )

    end

  end

  describe "#def_mapping" do

    context "with a Hash" do

      let(:region_map) do
        {
          "us-east-1"      => { "32" => "ami-6411e20d" },
          "us-west-1"      => { "32" => "ami-c9c7978c" },
          "eu-west-1"      => { "32" => "ami-37c2f643" },
          "ap-southeast-1" => { "32" => "ami-66f28c34" },
          "ap-northeast-1" => { "32" => "ami-9c03a89d" }
        }
      end

      before do
        template_builder.def_mapping("RegionMap", region_map)
      end

      it "defines a Mapping" do
        expect(template["Mappings"]).to eq("RegionMap" => region_map)
      end

    end

    context "with a block" do

      before do
        template_builder.def_mapping("RegionMap") do |map|
          map["ap-southeast-2"] = "foo"
          map["us-east-1"] = "bar"
        end
      end

      it "defines a Mapping" do
        expected_mapping = {
          "ap-southeast-2" => "foo",
          "us-east-1" => "bar"
        }
        expect(template["Mappings"]).to eq("RegionMap" => expected_mapping)
      end

    end

  end

  describe "#metadata" do

    it "allows attachment of stack metadata" do
      template_builder.metadata["Foo"] = { "bar" => "baz" }
      expected_metadata = {
        "Foo" => {
          "bar" => "baz"
        }
      }
      expect(template["Metadata"]).to eq(expected_metadata)
    end

  end
end
