
require "da_spec"
require "../src/da_path"

extend DA_SPEC

describe ".matches?" do
  it "returns false if string is different size" do
    assert DA_Path.new("/abc").matches?("/abc/") == false
  end # === it "returns false if string is different size"
end # === desc ".matches?"
