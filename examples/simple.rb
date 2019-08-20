#! /usr/bin/env ruby
# frozen_string_literal: true

require "cloud_shaped"
require "yaml"

template = CloudShaped.template do

  self.description = "Make a bucket"

  metadata["foo"] = {
    "bar" => "baz"
  }

  def_resource "myBucket", "AWS::S3::Bucket" do |b|
    b["BucketName"] = "my-bucket"
  end

end

puts YAML.dump(template)
