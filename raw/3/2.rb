#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aoc'
require 'strscan'

DAY = 3

input = AoC::Input.read(DAY)
lines = AoC::Input.readlines(DAY).map(&:strip)

Match = Data.define(:x, :y, :str) do
  def neighborhood
    (-1..str.size).flat_map { |pos|
      [
        [x + pos, y - 1], [x + pos, y], [x + pos, y + 1]
      ]
    }.filter { |c| c.all? { _1 >= 0 } }
  end

  def near?(other)
    my_space = str.size.times.map { [x, y + _1] }
    other.neighborhood.intersect?(my_space)
  end
end

nums = []
syms = []

lines.each_with_index do |l, y|
  s = StringScanner.new(l)
  while s.scan_until(/\d+/)
    nums << Match.new(y:, x: s.pos - s.matched_size, str: s.matched)
  end

  s.reset
  while s.scan_until(/\*/)
    syms << Match.new(y:, x: s.pos - s.matched_size, str: s.matched)
  end
end

gears = syms.map { |s| nums.filter { s.near? _1 } }

puts gears.filter { _1.size == 2 }.map { |g| g.map { _1.str.to_i }.inject(:*) }.sum
