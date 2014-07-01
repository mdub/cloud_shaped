require 'spec_helper'

require 'cloud_shaped/core_methods'

describe CloudShaped::CoreMethods do

  include described_class

  describe "#resource" do

    it "provides a bit of sugar" do
      output = resource("AWS::Thing", "X" => 1, "Y" => 2)
      expect(output).to eq(
        "Type" => "AWS::Thing",
        "Properties" => { "X" => 1, "Y" => 2 }
      )
    end

    it "weeds out null properties" do
      output = resource("AWS::Thing", "X" => 1, "Y" => nil)
      expect(output).to eq(
        "Type" => "AWS::Thing",
        "Properties" => { "X" => 1 }
      )
    end

  end

  describe "#tag" do

    it "generates a tag Hash" do
      output = tag("name", "foo")
      expect(output).to eq(
        "Key" => "name",
        "Value" => "foo"
      )
    end

    it "supports extra parameters" do
      output = tag("foo", "bar", "PropagateAtLaunch" => "yup")
      expect(output).to eq(
        "Key" => "foo",
        "Value" => "bar",
        "PropagateAtLaunch" => "yup"
      )
    end

  end

  describe "#ref" do

    context "with a logical resource name" do

      it "generates a Ref" do
        output = ref("thingy")
        expect(output).to eq("Ref" => "thingy")
      end

    end

    context "with a logical resource name, and attribute name" do

      it "generates an Fn::GetAtt" do
        output = ref("thingy", "wotsit")
        expect(output).to eq("Fn::GetAtt" => ["thingy", "wotsit"])
      end

    end

  end

end
