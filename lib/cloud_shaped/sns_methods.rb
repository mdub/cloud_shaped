# frozen_string_literal: true

require "cloud_shaped/core_methods"

module CloudShaped
  # Methods to create sns topics
  module SnsMethods
    include CoreMethods

    def sns_topic(endpoint)
      proto, target = sns_proto_target(endpoint)
      resource "AWS::SNS::Topic", "Subscription" => [
        { "Protocol" => proto, "Endpoint" => target }
      ]
    end

    private

    def sns_proto_target(target)
      case target
      when /^(https?):/
        [Regexp.last_match[1].upcase, target]
      when /^(mailto):(.*)/
        ["email", Regexp.last_match[2]]
      else ["email", target]
      end
    end
  end
end
