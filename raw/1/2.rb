input = File.readlines (ARGV[0] || './input.txt')

# Map digits to characters
digits = %w[zero one two three four five six seven eight nine]
  .each_with_index
  .to_h { |val, idx| [val, idx.to_s] }

digit_alt = digits.keys.join('|')
digit_re = /(\d|#{digit_alt})/
rev_digit_re = /(\d|#{digit_alt.reverse})/

list = input.map { |l|
  [l[digit_re], l.reverse[rev_digit_re].reverse]
    .map { digits[_1] || _1 }
    .join
    .to_i
}

puts list.sum


