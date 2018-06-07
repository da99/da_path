
da\_path.cr
============

```crystal
  path = DA_Path.new("/my_path/to/somewhere?a=b&c=d")
  path == ("/my_path/to/somewhere")       # false
  path == "/my_path/to/somewhere?a=b&c=d" # true
  path.starts_with?("/my_path")           # true
  path.split('/')                         # Deque(DA_Path::Token)

  path.params("/my_path/", :dir, :target)[:dir]    # "to"
  path.params("/my_path/", :dir, :target)[:target] # "somewhere?a=b&c=d"
  path.params("/my_path/to/", :target)[:target]    # "somewhere?a=b&c=d"
```
