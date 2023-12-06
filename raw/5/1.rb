#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aoc'

DAY = 5

input = AoC::Input.read(DAY)
lines = AoC::Input.readlines(DAY)

maps = input.split("\n\n")

MapRange = Data.define(:src, :dst, :len) do
  def include?(i)
    (src...(src + len)).include? i
  end

  def map(i)
    return nil unless include?(i)

    dst + (i - src)
  end
end

Map = Data.define(:from, :to, :ranges) do
  def map(val)
    ranges.each do |r|
      return r.map(val) if r.include?(val)
    end

    val
  end
end

seeds = maps[0][/seeds: \K.*/].split.map(&:to_i)

maps2 = maps[1..].map { |m|
  head, *body = m.split("\n")

  re = /(\w+)-to-(\w+).*/
  from, to = head[re, 1], head[re, 2]

  ranges = body.map { |line|
    dst, src, len = line.split.map(&:to_i)
    MapRange.new(src:, dst:, len:)
  }

  Map.new(from: from.to_sym, to: to.to_sym, ranges:)
}

locs = seeds.map { |s|
  maps2.reduce(s) { |acc, val| val.map(acc) }
}
pp locs.min
