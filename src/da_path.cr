
struct DA_Path

  @raw = Deque(Char).new
  delegate :size, :empty?, to: @raw

  def initialize
  end # === def initialize

  def initialize(s : String)
    s.each_char { |c|
      @raw.push c
    }
  end # === def initialize

  def starts_with?(s : String)
    return false if s.size > size
    return false if s.empty?
    return false if empty?
    s.each_char_with_index { |c, i|
      return false if !(self[i] == c)
    }
    true
  end # === def starts_with?

  def matches?(s : String)
    return false if s.empty?
    return false if empty?
    return false if s.size != size

    s.each_char_with_index { |c, i|
      return false if !(self[i] == c)
    }
    true
  end # === def matches?

  def push(c : Char)
    @raw.push c
    self
  end

  def [](i : Int32)
    @raw[i]
  end

  def []?(i : Int32)
    @raw[i]?
  end

  def split(delimiter : Char = '/')
    tokens = Deque(DA_Path).new
    t = DA_Path.new

    each_with_index { |c, i|
      case
      when c == delimiter
        next if t.empty?
        tokens.push t
        t = DA_Path.new

      when i == size
        tokens.push t
        t = DA_Path.new

      else
        t.push c

      end
    }

    tokens
  end

  def each
    @raw.each { |c| yield c }
  end

  def each_with_index
    @raw.each_with_index { |c, i| yield c, i }
  end

end # === struct DA_Path