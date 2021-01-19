def print_odd
  (0...99).each do |i|
    unless i%2 == 0
      puts i
    end
  end
end

def find_largest(arr)
  max = nil
  arr.each do |i|
    if max.nil? or i > max
      max = i
    end
  end
  max
end

def first_four(arr)
  result = []
  arr.each do |e|
    if result[0].nil?
      result << e
    elsif e <= result.last
      if result.count == 4
        result.shift
      end
      result << e
    elsif e < result[0]
      result[0] = e
    end
  end
  result
end
