
struct DA_Path

  struct Word

    @raw = Deque(Char).new
    delegate :size, :first, :last, :empty?, :[], :[]?, to: @raw

    def initialize(s : String)
      last_index = s.size - 1
      s.each_char_with_index { |c, i|
        next if i == 0 && c == '/'
        next if i == last_index && c == '/'
        @raw.push c
      }
    end # === def initialize

    def each_char_with_index
      @raw.each_with_index { |c, i|
        yield c, i
      }
    end # === def each_char_with_index

  end # === struct Word

  # =============================================================================
  # Instance:
  # =============================================================================

  getter tokens = Deque(DA_Path).new

  @raw = Deque(Char).new
  delegate :first, :first?, :last, :last?, :size, :empty?, to: @raw

  def initialize
  end # === def initialize

  def initialize(s : String)
    last_index = s.size - 1
    token = DA_Path.new
    s.each_char_with_index { |c, i|
      case c
      when '/'
        if i != 0
          @tokens.push token
          token = DA_Path.new
        end
      else
        token.push c
        if i == last_index
          @tokens.push token
          token = DA_Path.new
        end
      end

      @raw.push c
    }
  end # === def initialize

  def ==(c : Char)
    return false if size != 1
    first == c
  end # === def ==

  def ==(s : String | Word)
    return false if size != s.size
    s.each_char_with_index { |c, i|
      return false unless @raw[i] == c
    }
    true
  end

  def starts_with?(s : String)
    return false if s.size > size
    return false if s.empty?
    return false if empty?
    s.each_char_with_index { |c, i|
      return false if !(self[i] == c)
    }
    true
  end # === def starts_with?

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

      when i == (size - 1)
        t.push c
        tokens.push t
        t = DA_Path.new

      else
        t.push c

      end
    }

    tokens
  end # def split

  def each
    @raw.each { |c| yield c }
  end

  def each_with_index
    @raw.each_with_index { |c, i| yield c, i }
  end

  def params(*args)
    target = Deque(DA_Path | Symbol).new

    args.each { |x|
      case x
      when String
        DA_Path.new(x).tokens.each { |t|
          target.push t
        }
      when Symbol
        target.push x
      else
        raise Exception.new("Invalid type for param: #{x.inspect}")
      end
    }

    return nil if tokens.size != target.size

    vals = {} of Symbol => String
    target.each_with_index { |x, i|
      t = @tokens[i]
      case x
      when DA_Path
        return nil unless t == x
      when Symbol
        vals[x] = t.to_s
      end
    }

    vals
  end # === def params

  def to_s(io)
    @raw.each { |c|
      io << c
    }
    io
  end

end # === struct DA_Path
