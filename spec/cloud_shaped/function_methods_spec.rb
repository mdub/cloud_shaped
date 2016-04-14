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

  describe "#fn_and" do

    it "is sugar for Fn::And" do
      output = fn_and("cond1", "cond2", "cond3")
      expect(output).to eq(
        "Fn::And" => ["cond1", "cond2", "cond3"]
      )
    end

  end

  describe "#fn_equals" do

    it "is sugar for Fn::And" do
      output = fn_equals("val1", "val2")
      expect(output).to eq(
        "Fn::Equals" => ["val1", "val2"]
      )
    end

  end

  describe "#fn_if" do

    it "is sugar for Fn::If" do
      output = fn_if("cond", "when_true", "when_false")
      expect(output).to eq(
        "Fn::If" => ["cond", "when_true", "when_false"]
      )
    end

  end

  describe "#fn_not" do

    it "is sugar for Fn::Not" do
      output = fn_not("cond")
      expect(output).to eq(
        "Fn::Not" => ["cond"]
      )
    end

  end

  describe "#fn_or" do

    it "is sugar for Fn::Or" do
      output = fn_or("cond1", "cond2", "cond3")
      expect(output).to eq(
        "Fn::Or" => ["cond1", "cond2", "cond3"]
      )
    end

  end

end
