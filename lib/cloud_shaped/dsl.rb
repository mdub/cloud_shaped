require "cloud_shaped/core_methods"
require "cloud_shaped/function_methods"
require "cloud_shaped/interpolation"
require "cloud_shaped/sns_methods"

module CloudShaped
  module DSL

    include CoreMethods
    include FunctionMethods
    include Interpolation
    include SnsMethods

    extend self

  end
end
