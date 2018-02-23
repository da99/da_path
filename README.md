
da\_path.cr
============

```crystal
  path = DA_Path.new("/my_path/to/somewhere?a=b&c=d")
  path.matches?("/my_path/to/somewhere") == false
  path.matches?("/my_path/to/somewhere?a=b&c=d") == true
  path.starts_with?("/my_path") == true
  path.includes?('?') == true
  path.split('/') # Deque(DA_Path::Token)
```
