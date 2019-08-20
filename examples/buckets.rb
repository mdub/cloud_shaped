#! /usr/bin/env ruby
# frozen_string_literal: true

require "cloud_shaped"
require "yaml"

class BucketMaker

  def initialize(n_buckets = 1)
    @n_buckets = n_buckets
  end

  def template
    CloudShaped.template do |t|
      1.upto(@n_buckets) do |i|
        t.def_resource "bucket#{i}", "AWS::S3::Bucket" do |b|
          b["BucketName"] = "my-bucket-#{i}"
        end
      end
    end
  end

end

puts YAML.dump(BucketMaker.new(3).template)
