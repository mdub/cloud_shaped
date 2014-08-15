require 'spec_helper'

require 'cloud_shaped/core_methods'

describe CloudShaped::CoreMethods do

  include described_class

  describe "#resource" do

    it "generates a Resource" do
      expect(resource("AWS::Thing", "X" => 1, "Y" => 2)).to eq(
        "Type" => "AWS::Thing",
        "Properties" => { "X" => 1, "Y" => 2 }
      )
    end

    it "weeds out null properties" do
      expect(resource("AWS::Thing", "X" => 1, "Y" => nil)).to eq(
        "Type" => "AWS::Thing",
        "Properties" => { "X" => 1 }
      )
    end
    
    it "honours the DependsOn tag" do
      expect(resource("AWS::Thing", 'dependson' => 'some_other_thing', "X" => 1, "Y" => nil)).to eq(
        "Type" => "AWS::Thing",
        "DependsOn" => "some_other_thing",
        "Properties" => { "X" => 1 }
      )
    end

    context "with a block" do

      it "allows properties to be added" do
        result = resource("AWS::Thing", "MinSize" => 1) do |thing|
          thing["MaxSize"] = 3
        end
        expect(result).to eq(
          "Type" => "AWS::Thing",
          "Properties" => { "MinSize" => 1, "MaxSize" => 3 }
        )
      end

    end

  end

  describe "#parameter" do

    it "generates a Parameter" do
      expect(parameter(:type => "Numeric")).to eq(
        "Type" => "Numeric"
      )
    end

    context "with no type" do

      it "defaults to 'String'" do
        expect(parameter()).to eq(
          "Type" => "String"
        )
      end

    end

    context "with a :default" do

      it "includes a Default" do
        expect(parameter(:default => "abc")).to eq(
          "Type" => "String",
          "Default" => "abc"
        )
      end

    end

    context "with a :description" do

      it "includes a Description" do
        expect(parameter(:description => "size in Gb")).to eq(
          "Type" => "String",
          "Description" => "size in Gb"
        )
      end

    end

  end

  describe "#output" do

    it "generates an Output" do
      expect(output("blah")).to eq(
        "Value" => "blah"
      )
    end

  end

  describe "#tag" do

    it "generates a tag Hash" do
      expect(tag("name", "foo")).to eq(
        "Key" => "name",
        "Value" => "foo"
      )
    end

    it "supports extra parameters" do
      expect(tag("foo", "bar", "PropagateAtLaunch" => "yup")).to eq(
        "Key" => "foo",
        "Value" => "bar",
        "PropagateAtLaunch" => "yup"
      )
    end

  end

  describe "#tags" do

    it "generates a list of tags" do
      expect(tags("first" => "foo", "last" => "bar")).to eq(
        [
          {
            "Key" => "first",
            "Value" => "foo"
          },
          {
            "Key" => "last",
            "Value" => "bar"
          }
        ]
      )
    end

  end

  describe "#ref" do

    context "with a logical resource name" do

      it "generates a Ref" do
        expect(ref("thingy")).to eq(
          "Ref" => "thingy"
        )
      end

    end

    context "with a logical resource name, and attribute name" do

      it "generates an Fn::GetAtt" do
        expect(ref("thingy", "wotsit")).to eq(
          "Fn::GetAtt" => ["thingy", "wotsit"]
        )
      end

    end

  end

end
