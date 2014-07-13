module CloudShaped

  module CoreMethods

    # Generate a resource declaration.
    #
    def resource(type, properties)
      {
        "Type" => type,
        "Properties" => properties.select { |k,v| v != nil }
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

    # Generate an output declaration.
    #
    def output(value)
      {
        "Value" => value
      }
    end

  end
end
