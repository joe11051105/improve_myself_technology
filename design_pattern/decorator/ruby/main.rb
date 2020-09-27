class Display
  def get_columns
    raise NotImplementedError
  end

  def get_rows
    raise NotImplementedError
  end

  def get_row_text(row_index)
    raise NotImplementedError
  end

  def show
    for i in 0..(get_rows - 1)
      puts get_row_text(i)
    end
  end
end

class StringDisplay < Display
  def initialize(string)
    @string = string
  end

  def get_columns
    @string.length
  end

  def get_rows
    1
  end

  def get_row_text(row_index)
    row_index == 0 ? @string : nil
  end
end

class MultiStringDisplay < Display
  def get_columns
    @strings.inject([]) do |string_lengths, string|
      string_lengths << string.length
    end.max
  end

  def get_rows
    @strings.size
  end

  def get_row_text(row_index)
    if row_index.between?(0, get_rows - 1)
      @strings[row_index] + " " * (get_columns - @strings[row_index].length)
    else
      nil
    end
  end

  def add(string)
    @strings ||= []
    @strings << string
  end
end

class Border < Display
  attr_accessor :display

  def initialize(display)
    @display = display
  end
end


class SideBorder < Border
  def initialize(display, border)
    @display = display
    @border = border
  end

  def get_columns
    1 + @display.get_columns + 1
  end

  def get_rows
    @display.get_rows
  end

  def get_row_text(row_index)
    @border + @display.get_row_text(row_index) + @border
  end
end

class FullBorder < Border
  def initialize(display)
    @display = display
  end

  def get_columns
    1 + @display.get_columns + 1
  end

  def get_rows
    1 + @display.get_rows + 1
  end

  def get_row_text(row_index)
    if row_index == 0 || row_index == @display.get_rows + 1
      "+#{'-' * @display.get_columns }+"
    else
      "|#{@display.get_row_text(row_index - 1)}|"
    end
  end
end

class UpDownBorder < Border
  def initialize(display, border)
    @display = display
    @border = border
  end

  def get_columns
    @display.get_columns
  end

  def get_rows
    1 + @display.get_rows + 1
  end

  def get_row_text(row_index)
    if row_index == 0 || row_index == @display.get_rows + 1
      "#{@border * @display.get_columns }"
    else
      "#{@display.get_row_text(row_index - 1)}"
    end
  end
end

a1 = StringDisplay.new("Hello Word")
a2 = SideBorder.new(a1, "*")
a3 = FullBorder.new(a1)
a4 = SideBorder.new(FullBorder.new(FullBorder.new(SideBorder.new(FullBorder.new(StringDisplay.new("Hello Word")), "*"))), "/")
a5 = FullBorder.new(UpDownBorder.new(SideBorder.new(UpDownBorder.new(SideBorder.new(StringDisplay.new("Hello Word"), "*"), "="), "|"), "/"))
a6 = MultiStringDisplay.new()
a6.add(" Good morning ")
a6.add(" Good afternoon ")
a6.add(" Good evening ")
a7 = SideBorder.new(a6, "#")
a8 = FullBorder.new(a6)

a1.show
a2.show
a3.show
a4.show
a5.show
a6.show
a7.show
a8.show
