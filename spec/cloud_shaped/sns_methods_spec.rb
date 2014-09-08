require 'spec_helper'

require 'cloud_shaped/sns_methods'

describe CloudShaped::SnsMethods do

  include described_class

  describe "#sns_topic" do

    context "with an email address" do

      it "generates an email resource" do
        output = sns_topic("root@example.com")
        expect(output).to eq(
          "Type" => "AWS::SNS::Topic",
          "Properties" => {
            "Subscription" => [
              { "Protocol" => "email", "Endpoint" => "root@example.com" }
            ]
          }
        )
      end

      it "generates an email resource after stripping mailto:" do
        output = sns_topic("mailto:root@example.com")
        expect(output).to eq(
          "Type" => "AWS::SNS::Topic",
          "Properties" => {
            "Subscription" => [
              { "Protocol" => "email", "Endpoint" => "root@example.com" }
            ]
          }
        )
      end

    end

    context "with an HTTP URL" do

      it "generates a webhook" do
        output = sns_topic("http://example.com/hitme")
        expect(output).to eq(
          "Type" => "AWS::SNS::Topic",
          "Properties" => {
            "Subscription" => [
              { "Protocol" => "HTTP", "Endpoint" => "http://example.com/hitme" }
            ]
          }
        )
      end

    end

    context "with an HTTPS URL" do

      it "generates a webhook" do
        output = sns_topic("https://example.com/hitme")
        expect(output).to eq(
          "Type" => "AWS::SNS::Topic",
          "Properties" => {
            "Subscription" => [
              { "Protocol" => "HTTPS", "Endpoint" => "https://example.com/hitme" }
            ]
          }
        )
      end

    end

  end
end

