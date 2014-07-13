require "cloud_shaped/camelate"

using CloudShaped::Camelate

module CloudShaped

  module CoreMethods

    # Returns a CloudFormation Resource declaration.
    #
    # Properties can be passed in the call, or defined using an optional block.
    #
    # @example
    #     resource("AWS::ElasticLoadBalancing::LoadBalancer", "Scheme" => "internal") do |elb|
    #       elb["SecurityGroups"] = [ref("appSecurityGroup")]
    #     end
    #
    # @param type [String] the resource type
    # @param properties [Hash] resource properties
    #
    def resource(type, properties = {})
      properties = properties.camelate_keys
      yield properties if block_given?
      properties.select! { |k,v| v != nil }
      {
        "Type" => type,
        "Properties" => properties
      }
    end

    # Returns a CloudFormation Parameter declaration.
    #
    # @option options [String] :type ("String") the resource type
    # @option options [String] :description parameter description
    # @option options [String] :default a default value
    #
    def parameter(options = {})
      defaults = {
        "Type" => "String"
      }
      defaults.merge(options.camelate_keys)
    end

    # Generate an Output declaration.
    #
    def output(value)
      {
        "Value" => value
      }
    end

    # Generate a tag.
    #
    def tag(name, value, extra_properties = {})
      {
        "Key" => name,
        "Value" => value
      }.merge(extra_properties)
    end

    # Refer to another resource.
    #
    # If `attribute_name` is specified, we use "Fn::GetAtt"; otherwise, we use "Ref".
    #
    def ref(resource_name, attribute_name = nil)
      if attribute_name
        { "Fn::GetAtt" => [resource_name, attribute_name] }
      else
        { "Ref" => resource_name }
      end
    end

  end
end
