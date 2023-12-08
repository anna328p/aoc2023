#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aoc'

DAY = 8

input = AoC::Input.read(DAY)
lines = AoC::Input.readlines(DAY)

insns = lines[0].strip.chars.map { |c| { 'L' => :left, 'R' => :right }[c] }

maps = lines[2..].to_h { |line|
  _, n, l, r = *line.match(/(...) = \((...), (...)\)/)
  [n, [l, r]]
}

positions = maps.keys.filter { _1.end_with? 'A' }

counts = positions.map { |pos|
  count = 0

  insns.cycle do |dir|
    break if pos.end_with? 'Z'

    count += 1
    n = maps[pos]
    pos = dir == :left ? n[0] : n[1]
  end

  count
}

pp counts.reduce(1) { |a, b| a.lcm(b) }
