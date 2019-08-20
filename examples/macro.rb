#! /usr/bin/env ruby
# frozen_string_literal: true

require "cloud_shaped"
require "yaml"

module ScalingMacros

  def asg_adjustment(asg_resource_name, adjustment, cooldown = 120)
    resource("AWS::AutoScaling::ScalingPolicy") do |p|
      p["AdjustmentType"] = "ChangeInCapacity"
      p["AutoScalingGroupName"] = ref(asg_resource_name)
      p["ScalingAdjustment"] = adjustment
      p["Cooldown"] = cooldown
    end
  end

end

template = CloudShaped.template do

  extend(ScalingMacros)

  def_resource "upOne", :asg_adjustment, "autoScalingGroup", 1
  def_resource "downOne", :asg_adjustment, "autoScalingGroup", -1

end

puts YAML.dump(template)
