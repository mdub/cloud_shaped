require "cloud_shaped/dsl"
require "cloud_shaped/template_builder"
require "cloud_shaped/version"

module CloudShaped

  def self.build_template(&block)
    TemplateBuilder.new.tap do |builder|
      builder.instance_eval(&block)
    end.template
  end

end
