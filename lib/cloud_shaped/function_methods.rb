# frozen_string_literal: true

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

    # Syntax sugar for Fn::And.
    #
    def fn_and(*conditions)
      {
        "Fn::And" => conditions
      }
    end

    # Syntax sugar for Fn::Equals.
    #
    def fn_equals(v1, v2)
      {
        "Fn::Equals" => [v1, v2]
      }
    end

    # Syntax sugar for Fn::If.
    #
    def fn_if(condition, when_true, when_false)
      {
        "Fn::If" => [condition, when_true, when_false]
      }
    end

    # Syntax sugar for Fn::Not.
    #
    def fn_not(cond)
      {
        "Fn::Not" => [cond]
      }
    end

    # Syntax sugar for Fn::Or.
    #
    def fn_or(*conditions)
      {
        "Fn::Or" => conditions
      }
    end

  end

end
