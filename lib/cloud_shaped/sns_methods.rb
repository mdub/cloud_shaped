require 'cloud_shaped/core_methods'

module CloudShaped

  module SnsMethods

    include CoreMethods

    def sns_topic(target)
      resource "AWS::SNS::Topic", "Subscription" => [
        { "Protocol" => sns_protocol(target), "Endpoint" => target }
      ]
    end

    private

    def sns_protocol(target)
      case target
      when /^(https?):/
        $1.upcase
      else "email"
      end
    end

  end

end
