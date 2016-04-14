require "spec_helper"

require "cloud_shaped/function_methods"

describe CloudShaped::FunctionMethods do

  include described_class

  describe "#fn_base64" do

    it "is sugar for Fn::Base64" do
      output = fn_base64("stuff")
      expect(output).to eq(
        "Fn::Base64" => "stuff"
      )
    end

  end

  describe "#fn_join" do

    it "is sugar for Fn::Join" do
      lines = %w(a b c)
      output = fn_join(",", lines)
      expect(output).to eq(
        "Fn::Join" => [",", lines]
      )
    end

  end

end
