require 'spec_helper'

require 'cloud_shaped/core_methods'

describe CloudShaped::CoreMethods do

  include described_class

  describe "#resource" do

    it "provides a bit of sugar" do
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

  describe "#parameter" do

    context "with no type" do

      it "generates a String Parameter" do
        expect(parameter()).to eq(
          "Type" => "String"
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

end
