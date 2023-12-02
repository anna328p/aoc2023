#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aoc'

DAY = 2

lines = AoC::Input.readlines(DAY)

Game = Data.define(:id, :subsets) do
  def self.parse(line)
    id = line[/Game \K\d+/].to_i
    rest = line.sub(/^Game \d+: /, '')

    subsets = rest.split('; ').map { |sub|
      sub.split(', ').to_h { |entry|
        entry.split.then { |n, color| [color.to_sym, n.to_i] }
      }
    }

    new(id:, subsets:)
  end

  def valid?
    max = { red: 12, green: 13, blue: 14 }

    subsets.all? { |s| s.all? { |k, v| v <= max[k] } }
  end
end

input = lines.map { Game.parse(_1) }

allowed = input.filter(&:valid?)
puts allowed.sum(&:id)
