module CloudShaped

  module FunctionMethods

    # Syntax sugar for Fn::Base64.
    #
    def fn_base64(arg)
      { "Fn::Base64" => arg }
    end

    # Syntax sugar for Fn::Join.
    #
    def fn_join(separator, lines)
      {
        "Fn::Join" => [
          separator, lines
        ]
      }
    end

  end

end
