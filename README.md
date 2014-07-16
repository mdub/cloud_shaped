# CloudShaped

Infrastructure as <del>data</del> code.

[CloudFormation][cloud_formation] provides a nice way to provision AWS resources in a declarative way.  But, programming in JSON can be painful.

CloudShaped provides a simple, extensible DSL for generating CloudFormation templates.

## Installation

Add this line to your application's Gemfile:

    gem 'cloud_shaped'

## Example

    require 'cloud_shaped'
    require 'json'

    template = CloudShaped.template do
      def_parameter "appName"
      def_resource "app", "AWS::Appity:AppApp", "Name" => ref("appName")
      def_output "appAddress", ref("app", "address")
    end

    puts JSON.pretty_generate(template)

outputs

    {
      "AWSTemplateFormatVersion": "2010-09-09",
      "Parameters": {
        "appName": {
          "Type": "String"
        }
      },
      "Resources": {
        "app": {
          "Type": "AWS::Appity:AppApp",
          "Properties": {
            "Name": {
              "Ref": "appName"
            }
          }
        }
      },
      "Outputs": {
        "appAddress": {
          "Value": {
            "Fn::GetAtt": ["app", "address"]
          }
        }
      }
    }

For more info on the DSL, see:

* {CloudShaped.template}
* {CloudShaped::TemplateBuilder}

## Contributing

It's [on GitHub][cloud_shaped]. Fork it.

[cloud_formation]: http://aws.amazon.com/cloudformation/
[cloud_shaped]: https://github.com/mdub/cloud_shaped
