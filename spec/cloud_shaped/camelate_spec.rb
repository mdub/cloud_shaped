require 'spec_helper'

require 'cloud_shaped/camelate'

describe CloudShaped::Camelate do

  include described_class

  describe "#camelate" do

    context "with a String" do
      it "returns the input" do
        expect(camelate("foobar")).to eq("foobar")
      end
    end

    context "with a Symbol" do
      it "returns a CamelCased string" do
        expect(camelate(:foo_bar)).to eq("FooBar")
      end
    end

  end

end
