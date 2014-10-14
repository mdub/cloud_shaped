require 'spec_helper'

require 'cloud_shaped/interpolation'

describe CloudShaped::Interpolation do

  include described_class

  describe "#interpolate" do

    let(:output) { interpolate(input) }

    context "with a resource or parameter name" do

      let(:input) { "prefix-{{myResource}}-suffix" }

      it "generates a Ref" do
        expect(output).to eq(
          {
            "Fn::Join" => [
              "", [
                "prefix-",
                { "Ref" => "myResource" },
                "-suffix"
              ]
            ]
          }
        )
      end

    end

    context "with a built-in CloudFormation resource" do

      let(:input) { "{{AWS::StackName}}" }

      it "generates a Ref" do
        expect(output).to eq(
          {
            "Fn::Join" => [
              "", [
                { "Ref" => "AWS::StackName" }
              ]
            ]
          }
        )
      end

    end

    context "with a built-in CloudFormation resource surrounded by other stuff" do

      let(:input) { "prefix-{{AWS::StackName}}-suffix" }

      it "generates a Ref" do
        expect(output).to eq(
          {
            "Fn::Join" => [
              "", [
                "prefix-",
                { "Ref" => "AWS::StackName" },
                "-suffix"
              ]
            ]
          }
        )
      end

    end

    context "with a resource name and attribute" do

      let(:input) { "{{loadBalancer.cname}}" }

      it "generates an Fn::GetAtt" do
        expect(output).to eq(
          {
            "Fn::Join" => [
              "", [
                { "Fn::GetAtt" => ["loadBalancer", "cname"] },
              ]
            ]
          }
        )
      end

    end

    it "supports alternate delimiters" do
      double_square_brackets = ["[[", "]]"]
      expect(interpolate("[[foo]]", double_square_brackets)).to eq(
          {
            "Fn::Join" => [
              "", [
                { "Ref" => "foo" }
              ]
            ]
          }
        )
    end

    context "with a mix of stuff" do

      let(:input) { "#!/bin/foo\n\nprefix-{{myResource}}-suffix\n" }

      it "all just works" do
        expect(output).to eq(
          {
            "Fn::Join" => [
              "", [
                "#!/bin/foo\n",
                "\n",
                "prefix-",
                { "Ref" => "myResource" },
                "-suffix\n"
              ]
            ]
          }
        )
      end

    end

  end

end
