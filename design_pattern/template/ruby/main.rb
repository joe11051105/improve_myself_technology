class AbstractDisplay
  def open
    raise NotImplementedError
  end

  def print
    raise NotImplementedError
  end

  def close
    raise NotImplementedError
  end

  def display
    open
    for i in 0..4
      print
    end
    close
    puts ""
  end
end

class CharDisplay < AbstractDisplay
  attr_accessor :string

  def initialize(string)
    @string = string
  end

  def open
    $stdout.print "<<"
  end

  def print
    $stdout.print @string
  end

  def close
    $stdout.print ">>"
  end
end

class StringDisplay < AbstractDisplay
  attr_accessor :string, :witch

  def initialize(string)
    @string = string
    @witch = @string.bytes.length
  end

  def open
    print_line
  end

  def print
    puts "|#{@string}|"
  end

  def close
    print_line
  end

  private

  def print_line
    $stdout.print "+"
    for i in 0..@witch - 1
      $stdout.print "-"
    end
    puts "+"
  end
end

a1 = CharDisplay.new("h")
a2 = StringDisplay.new("Hello world")

a1.display
a2.display
