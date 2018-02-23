
require "da_spec"
require "inspect_bang"
require "../src/da_path"

extend DA_SPEC

describe "root?" do

  it "returns true if path == \"/\"" do
    assert DA_Path.new("/").root? == true
  end # === it "returns true if path == \"/\""

end # === desc "root?"

describe "starts_with?" do

  it "returns true if string is a prefix of original" do
    assert DA_Path.new("/abc/def").starts_with?("/abc") == true
  end # === it "returns true if string is a prefix of original"

  it "returns false if string is longer than original" do
    assert DA_Path.new("/abc").starts_with?("/abc/def") == false
  end # === it "returns false if string is longer than original"

  it "returns true for: DA_Path.new(\"/@name\").starts_with?('/', '@')" do
    assert DA_Path.new("/@name").starts_with?('/', '@') == true
  end # === it "returns true for: .matches?('/')"

end # === desc "starts_with?"

describe ".matches?" do

  it "returns false if string is different size" do
    assert DA_Path.new("/abc").matches?("/abc/") == false
  end # === it "returns false if string is different size"

  it "returns true if string matches in size and char values" do
    assert DA_Path.new("/abc").matches?("/abc") == true
  end # === it "returns true if string matches in size and char values"

  it "returns true for: DA_Path.new(\"/\").matches?('/')" do
    assert DA_Path.new("/").matches?('/') == true
  end # === it "returns true for: .matches?('/')"

end # === desc ".matches?"

describe "splits" do
  it "returns a Deque of DA_Path" do
    actual = DA_Path.new("/abc/def").split('/')
    val = actual.is_a?(Deque(DA_Path))
    assert val == true
  end # === it "returns a Deque of Path"

  it "splits into 2 parts: /abc/def/" do
    actual = DA_Path.new("/abc/def/").split('/')
    assert actual.map(&.to_s).join(" ") == "abc def"
  end # === it "ignores empty parts"

  it "splits into 2 parts: /abc/def" do
    actual = DA_Path.new("/abc/def").split('/')
    assert actual.map(&.to_s).join(" ") == "abc def"
  end # === it "splits into 2 parts: /abc/def"

end # === desc "splits"

