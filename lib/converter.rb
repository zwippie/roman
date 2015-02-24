class SAConverter

  INT_VAL = {
    'I' => 1,
    'V' => 5,
    'X' => 10,
    'L' => 50,
    'C' => 100,
    'D' => 500,
    'M' => 1000
  }

  ROMAN_VAL = INT_VAL.invert

  SPECIAL = {
    4 => 'IV',
    9 => 'IX',
    40 => 'XL',
    90 => 'XC',
    400 => 'CD',
    900 => 'CM'
  }


  def initialize(roman, mode='arabic')
    @roman = roman
    @mode = mode
  end

  def +(other)
    result = self.to_i + other.to_i
    @mode == 'arabic' ? result : to_roman(result)
  end

  def -(other)
    self.to_i - other.to_i
  end

  def *(other)
    self.to_i * other.to_i
  end

  def /(other)
    self.to_i / other.to_i
  end

  def lookup
    @lookup ||= Hash[(ROMAN_VAL.merge SPECIAL).sort.reverse]
  end

  def to_roman(val)
    result = ''
    while val > 0
      k, v = *find_largest(val)
      val -= k
      result << v
    end
    result
  end

  def find_largest(val)
    lookup.each do |k, v|
      return [k,v] if k <= val
    end
  end

  # Use this method to convert roman numbers to arabic
  #
  # Don't you dare cheat on spec!!!
  def to_i
    value = 0
    @roman.split(//).each.with_index do |char, i|
      char_val = INT_VAL[char]
      next_char = (i + 1 < @roman.length) ? @roman[i + 1] : false
      if next_char && INT_VAL[next_char] > char_val
        value -= char_val
      else
        value += char_val
      end
    end
    value
  end
end
