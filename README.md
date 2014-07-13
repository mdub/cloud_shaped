# CloudShaped

Infrastructure as <del>data</del> code.

[CloudFormation][cloud_formation] provides a nice way to provision AWS resources in a declarative way.  But, programming in JSON can be painful.

CloudShaped provides a simple, extensible DSL for generating CloudFormation templates.

## Installation

Add this line to your application's Gemfile:

    gem 'cloud_shaped'

## Example

    require 'cloud_shaped'

    template = CloudShaped.template do |t|
      t.def_parameter "appName"
      t.def_resource "app", "AWS::Appity:AppApp" do |app|
        app["Name"] = t.ref("appName")
      end
      t.def_output "appAddress", t.ref("app", "address")
    end

## Contributing

It's [on GitHub][cloud_shaped]. Fork it.

[cloud_formation]: http://aws.amazon.com/cloudformation/
[cloud_shaped]: https://github.com/mdub/cloud_shaped
