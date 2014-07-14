#! /usr/bin/env ruby

require 'cloud_shaped'
require 'yaml'

def make_buckets(n_buckets = 1)
  CloudShaped.template do |t|
    1.upto(n_buckets) do |i|
      bucket_name = "buckety_#{i}"
      t.def_resource "bucket#{i}", "AWS::S3::Bucket" do |b|
        b["BucketName"] = "my-bucket-#{i}"
      end
    end
  end
end

puts YAML.dump(make_buckets(3))
