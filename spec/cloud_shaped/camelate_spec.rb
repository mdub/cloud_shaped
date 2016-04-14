require "spec_helper"

require "cloud_shaped/camelate"

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

describe Hash, "#camelate_keys" do

  it "camelates the keys" do
    original_hash = {
      :foo_bar => 123,
      "BlahBlah" => 456
    }
    expect(original_hash.camelate_keys).to eq(
      "FooBar" => 123,
      "BlahBlah" => 456
    )
  end

end
