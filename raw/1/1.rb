input = File.readlines './input.txt'

puts input.map { |line| line.chars.filter { _1.match? /\d/ }.values_at(0, -1).join.to_i }.sum
