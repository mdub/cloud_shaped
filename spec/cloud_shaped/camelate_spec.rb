require 'spec_helper'

require 'cloud_shaped/camelate'

using CloudShaped::Camelate

describe String, "#camelate" do
  it "is a no-op" do
    expect("foobar".camelate).to eq("foobar")
  end
end

describe Symbol, "#camelate" do
  it "returns a CamelCased string" do
    expect(:foo_bar.camelate).to eq("FooBar")
  end
end
