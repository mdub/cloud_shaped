#! /usr/bin/env ruby

require 'cloud_shaped'
require 'yaml'

template = CloudShaped.template do

  self.description = "Make a bucket"

  self.metadata["foo"] = {
    "bar" => "baz"
  }

  def_resource "myBucket", "AWS::S3::Bucket" do |b|
    b["BucketName"] = "my-bucket"
  end

end

puts YAML.dump(template)
