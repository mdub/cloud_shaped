require 'spec_helper'

require 'cloud_shaped/core_methods'

describe CloudShaped::CoreMethods do

  include described_class

  describe "#resource" do

    it "provides a bit of sugar" do
      result = resource("AWS::Thing", "X" => 1, "Y" => 2)
      expect(result).to eq(
        "Type" => "AWS::Thing",
        "Properties" => { "X" => 1, "Y" => 2 }
      )
    end

    it "weeds out null properties" do
      result = resource("AWS::Thing", "X" => 1, "Y" => nil)
      expect(result).to eq(
        "Type" => "AWS::Thing",
        "Properties" => { "X" => 1 }
      )
    end

  end

  describe "#tag" do

    it "generates a tag Hash" do
      result = tag("name", "foo")
      expect(result).to eq(
        "Key" => "name",
        "Value" => "foo"
      )
    end

    it "supports extra parameters" do
      result = tag("foo", "bar", "PropagateAtLaunch" => "yup")
      expect(result).to eq(
        "Key" => "foo",
        "Value" => "bar",
        "PropagateAtLaunch" => "yup"
      )
    end

  end

  describe "#ref" do

    context "with a logical resource name" do

      it "generates a Ref" do
        result = ref("thingy")
        expect(result).to eq("Ref" => "thingy")
      end

    end

    context "with a logical resource name, and attribute name" do

      it "generates an Fn::GetAtt" do
        result = ref("thingy", "wotsit")
        expect(result).to eq("Fn::GetAtt" => ["thingy", "wotsit"])
      end

    end

  end

  describe "#output" do

    it "provides a bit of sugar" do
      result = output("blah")
      expect(result).to eq(
        "Value" => "blah"
      )
    end

  end

end
