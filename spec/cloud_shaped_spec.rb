require 'spec_helper'

require "cloud_shaped"

describe CloudShaped do

  describe ".template" do

    context "with a no-arg block" do

      let!(:template) do
        CloudShaped.template do
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

    context "with a block that takes an argument" do

      let(:app_name_parameter) { "appName" }

      let!(:template) do
        CloudShaped.template do |t|
          t.def_parameter app_name_parameter
          t.def_resource "app", "AWS::Appity:AppApp" do |app|
            app["Name"] = t.ref(app_name_parameter)
          end
          t.def_output "appAddress", t.ref("app", "address")
        end
      end

      it "declares a template without instance_eval" do
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
