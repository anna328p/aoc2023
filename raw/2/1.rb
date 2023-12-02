#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aoc'

DAY = 2

lines = AoC::Input.readlines(DAY)

input = lines.map { |l|
  id = l[/Game \K\d+/].to_i
  _, rest = l.split(': ')
  subsets = rest.split('; ').map { |s|
    s.split(', ').to_h { a, b = _1.split; [b.to_sym, a.to_i] }
  }

  { id:, subsets: }
}

max = { red: 12, green: 13, blue: 14 }

allowed =  input.filter { |game| game[:subsets].all? { |s| s.each.all? { |k, v| v <= max[k] } } }
pp allowed.sum { _1[:id] }
