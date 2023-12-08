#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aoc'

DAY = 8

input = AoC::Input.read(DAY)
lines = AoC::Input.readlines(DAY)

insns = lines[0].strip.chars.map { |c| { 'L' => :left, 'R' => :right }[c] }

maps = lines[3..].to_h { |line|
  _, n, l, r = *line.match(/(...) = \((...), (...)\)/)
  [n, [l, r]]
}

count = 0
pos = 'AAA'

insns.cycle do |dir|
  break if pos == 'ZZZ'

  count += 1
  n = maps[pos]
  pos = dir == :left ? n[0] : n[1]
end

pp count
