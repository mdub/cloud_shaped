require 'cloud_shaped/core_methods'
require 'cloud_shaped/function_methods'
require 'cloud_shaped/sns_methods'

module CloudShaped
  # Domain Specific Language methods for CF template generation
  module DSL
    include CoreMethods
    include FunctionMethods
    include SnsMethods

    extend self
  end
end
