require "cloud_shaped/dsl"
require "cloud_shaped/template_builder"
require "cloud_shaped/version"

module CloudShaped

  def self.template(&block)
    TemplateBuilder.new.tap do |builder|
      if block.arity.zero?
        builder.instance_eval(&block)
      else
        yield builder
      end
    end.template
  end

end
