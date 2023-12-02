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

pp input.map { |game|
  subsets = game[:subsets]
  %i[red green blue].map { |color| subsets.max_by { |ss| ss[color] || 0 }[color] }.inject(:*)
}.sum
