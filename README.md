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

    template = CloudShaped.template do |t|
      t.def_parameter "appName"
      t.def_resource "app", "AWS::Appity:AppApp", "Name" => t.ref("appName")
      t.def_output "appAddress", t.ref("app", "address")
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

## Declaring resources

Declare CloudFormation resources using the `def_resource` method.  It takes a resource name, type, and properties:

    t.def_resource "adminEmail", "AWS::SNS::Topic",
      "Subscription" => [{"Protocol" => "email", "Endpoint" => "mdub@example.com"}]

If you prefer, you can set properties using a block:

    t.def_resource "adminEmail", "AWS::SNS::Topic" do |topic|
      topic["Subscription"] = [
        { "Protocol" => "email", "Endpoint" => "mdub@example.com" }
      ]
    end

### Resource macros

Typically, the "type" argument will be a string specifying a CloudFormation resource type.  However, it's also possible to provide a Ruby symbol, in which case `def_resource` will call the named method, passing remaining arguments.  This allows common resource patterns to be abstracted as methods:

    def t.email_topic(address)
      resource "AWS::SNS::Topic",
        "Subscription" => [{ "Protocol" => "email", "Endpoint" => address }]
    end

    t.def_resource "adminEmail", :email_topic, "mdub@example.com"

## Full documentation

For more info on the DSL, see:

* {CloudShaped.template}
* {CloudShaped::TemplateBuilder}

## Contributing

It's [on GitHub][cloud_shaped]. Fork it.

[cloud_formation]: http://aws.amazon.com/cloudformation/
[cloud_shaped]: https://github.com/mdub/cloud_shaped
