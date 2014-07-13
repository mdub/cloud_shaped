require 'spec_helper'

require "cloud_shaped"

describe CloudShaped do

  describe ".build_template" do

    context "with a no-arg block" do

      let!(:template) do
        CloudShaped.build_template do
          def_parameter "appName"
          def_resource "app", "AWS::Appity:AppApp" do |app|
            app["Name"] = ref("appName")
          end
          def_output "appAddress", ref("app", "address")
        end
      end

      it "declares a template using instance_eval" do
        expect(template).to eq(
          "AWSTemplateFormatVersion" => '2010-09-09',
          "Parameters" => {
            "appName" => {
              "Type" => "String"
            }
          },
          "Resources" => {
            "app" => {
              "Type" => "AWS::Appity:AppApp",
              "Properties" => {
                "Name" => { "Ref" => "appName" }
              }
            }
          },
          "Outputs" => {
            "appAddress" => {
              "Value" => { "Fn::GetAtt" => ["app", "address"] }
            }
          }
        )
      end

    end

  end

end
