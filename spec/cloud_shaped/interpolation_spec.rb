require "spec_helper"

require "cloud_shaped/interpolation"

describe CloudShaped::Interpolation do

  include described_class

  describe "#interpolate" do

    let(:output) { interpolate(input) }

    context "with a resource or parameter name" do

      let(:input) { "prefix-{{myResource}}-suffix" }

      it "generates a Ref" do
        expect(output).to eq(
          "Fn::Join" => [
            "", [
              "prefix-",
              { "Ref" => "myResource" },
              "-suffix"
            ]
          ]
        )
      end

    end

    context "with multiple lines" do

      let(:input) { "line1\nline2\nline3\n" }

      it "uses Fn::Join to join lines" do
        expect(output).to eq(
          "Fn::Join" => [
            "\n", [
              "line1",
              "line2",
              "line3",
              ""
            ]
          ]
        )
      end

    end

    context "with a built-in CloudFormation resource" do

      let(:input) { "{{AWS::StackName}}" }

      it "generates a Ref" do
        expect(output).to eq(
          "Ref" => "AWS::StackName"
        )
      end

    end

    context "with a built-in CloudFormation resource surrounded by other stuff" do

      let(:input) { "prefix-{{AWS::StackName}}-suffix" }

      it "generates a Ref" do
        expect(output).to eq(
          "Fn::Join" => [
            "", [
              "prefix-",
              { "Ref" => "AWS::StackName" },
              "-suffix"
            ]
          ]
        )
      end

    end

    context "with a resource name and attribute" do

      let(:input) { "prefix-{{loadBalancer.cname}}-suffix" }

      it "generates an Fn::GetAtt" do
        expect(output).to eq(
          "Fn::Join" => [
            "", [
              "prefix-",
              { "Fn::GetAtt" => ["loadBalancer", "cname"] },
              "-suffix"
            ]
          ]
        )
      end

    end

    it "supports alternate delimiters" do
      double_square_brackets = ["[[", "]]"]
      expect(interpolate("blah[[foo]]blah", double_square_brackets)).to eq(
        "Fn::Join" => [
          "", [
            "blah",
            { "Ref" => "foo" },
            "blah"
          ]
        ]
      )
    end

    context "with a mix of stuff" do

      let(:input) { "#!/bin/foo\n\nprefix-{{myResource}}-suffix\n" }

      it "all just works" do
        expect(output).to eq(
          "Fn::Join" => [
            "\n", [
              "#!/bin/foo",
              "",
              {
                "Fn::Join" => [
                  "", [
                    "prefix-",
                    { "Ref" => "myResource" },
                    "-suffix"
                  ]
                ]
              },
              ""
            ]
          ]
        )
      end

    end

  end

end
