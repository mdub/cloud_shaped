require "cloud_shaped/camelate"

module CloudShaped

  module CoreMethods

    # Returns a CloudFormation Resource declaration.
    #
    # Properties and additional resource attributes can be passed in the call, or defined using an optional block.
    #
    # @example
    #     resource("AWS::ElasticLoadBalancing::LoadBalancer", "Scheme" => "internal") do |elb|
    #       elb["SecurityGroups"] = [ref("appSecurityGroup")]
    #     end
    #
    # @param type [String] the resource type
    # @param properties [Hash] resource properties
    # @param attributes [Hash] additional resource attributes
    #
    def resource(type, properties = {}, attributes = {})
      properties = properties.camelate_keys
      yield properties, attributes if block_given?
      properties.select! { |_k, v| !v.nil? }
      attributes.merge(
        "Type" => type,
        "Properties" => properties
      )
    end

    # Returns a CloudFormation Parameter declaration.
    #
    # @option options [String] :type ("String") the parameter type
    # @option options [String] :description parameter description
    # @option options [String] :default a default value
    #
    def parameter(options = {})
      defaults = {
        "Type" => "String"
      }
      defaults.merge(options.camelate_keys)
    end

    # Returns an Output declaration.
    #
    # @param value the output value (usually a reference to a resource)
    #
    # @example
    #   output(ref("loadBalancer"))
    #
    def output(value)
      {
        "Value" => value
      }
    end

    # Returns a Tag.
    #
    # @param key [String] tag name
    # @param value tag value
    # @return [Hash] a Tag structure
    #
    # @example
    #   tag("name", "bob") #=> { "Key" => "name", "Value" => "bob "}
    #
    def tag(key, value, extra_properties = {})
      {
        "Key" => key,
        "Value" => value
      }.merge(extra_properties)
    end

    # Returns a list of Tags.
    #
    # @param tag_map [Hash] mapping of Tag keys to values
    #
    # @example
    #   tags("application" => "atlas", "version" => "1.2.3")
    #
    def tags(tag_map, extra_properties = {})
      tag_map.map { |k, v| tag(k, v, extra_properties) }
    end

    # Returns a resource reference.
    #
    # If attribute_name is specified, we use "Fn::GetAtt"; otherwise, we use "Ref".
    #
    # @param resource_name [String] name of the resource
    # @param attribute_name [String] atttribute of the resource to refer to
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
