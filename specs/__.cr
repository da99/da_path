
require "da_spec"
require "inspect_bang"
require "../src/da_path"

extend DA_SPEC

describe "starts_with?" do

  it "returns true if string is a prefix of original" do
    assert DA_Path.new("/abc/def").starts_with?("/abc") == true
  end # === it "returns true if string is a prefix of original"

  it "returns false if string is longer than original" do
    assert DA_Path.new("/abc").starts_with?("/abc/def") == false
  end # === it "returns false if string is longer than original"


end # === desc "starts_with?"

describe "==" do

  it "returns true if path == \"/\"" do
    assert DA_Path.new("/") == "/"
  end # === it "returns true if path == \"/\""

  it "returns false if string is different size" do
    actual = DA_Path.new("/abc") == "/abc/"
    assert(actual == false)
  end # === it "returns false if string is different size"

  it "returns true if string matches in size and char values" do
    actual = DA_Path.new("/abc") == "/abc"
    assert( actual == true )
  end # === it "returns true if string matches in size and char values"

  it "returns true for: DA_Path.new(\"/\") == ('/')" do
    actual = DA_Path.new("/") == '/'
    assert actual == true
  end # === it "returns true for: .matches?('/')"

end # === desc "=="

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

describe "params" do

  it "returns a Hash(Symbol, String)" do
    path = DA_Path.new("/posts/cat/sort_by/date/asc")
    params = path.params("/posts/", :name, "/sort_by/", :category, :dir)
    if params
      assert params.is_a?(Hash(Symbol, String)) == true
    else
      assert params != nil
    end
  end # === it

  it "stores values" do
    path = DA_Path.new("/posts/cat/sort_by/date/asc")
    params = path.params("/posts/", :name, "/sort_by/", :category, :dir)
    if params
      assert params[:name] == "cat"
      assert params[:category] == "date"
      assert params[:dir] == "asc"
    else
      assert params != nil
    end
  end # === it "stores values"

  it "returns nil if arguments.size != word_count" do
    path = DA_Path.new("/posts/cat")
    params = path.params("/posts/", :name, "/sort_by/", :category, :dir)
    assert params == nil
  end # === it "returns nil if arguments.size != word_count"

  it "accepts strings: /posts/cat/..." do
    path = DA_Path.new("/posts/cat/a/b/c")
    params = path.params("/posts/cat/", :a, :b, :c)
    if params
      assert params[:a] == "a"
      assert params[:b] == "b"
      assert params[:c] == "c"
    else
      assert params != nil
    end
  end # === it "accepts strings: /posts/cat/..."

end # === desc "params"

