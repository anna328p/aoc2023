#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aoc'
require 'strscan'

DAY = 3

input = AoC::Input.read(DAY)
lines = AoC::Input.readlines(DAY).map(&:strip)

Match = Data.define(:x, :y, :str)

nums = []
syms = []

lines.each_with_index do |l, y|
  s = StringScanner.new(l)
  while s.scan_until(/\d+/)
    nums << Match.new(y:, x: s.pos - s.matched_size, str: s.matched)
  end

  s.reset
  while s.scan_until(/[^.\d]/)
    syms << Match.new(y:, x: s.pos - s.matched_size, str: s.matched)
  end
end

remaining = nums.filter { |n|
  checks = (-1..n.str.size).flat_map { |pos|
    [
      [n.x + pos, n.y - 1], [n.x + pos, n.y], [n.x + pos, n.y + 1]
    ]
  }.filter { |c| c.all? { _1 >= 0 } }

  checks.any? { |c| l = lines[c[1]]; c = l && l[c[0]]; c&.match?(/[^.\d]/) }
}

puts remaining.map { _1.str.to_i }.sum
