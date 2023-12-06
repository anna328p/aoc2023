#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aoc'

DAY = 5

input = AoC::Input.read(DAY)
lines = AoC::Input.readlines(DAY)

maps = input.split("\n\n")

MapRange = Data.define(:src, :dst, :len) do
  def src_range
    src...(src + len)
  end

  def dst_range
    dst...(dst + len)
  end

  def dst_end
    dst + len - 1
  end

  def include?(i)
    src_range.include? i
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

  def map_range(range)
    res = [range.begin] if map(range.begin) == range.begin

    ranges.sort_by(&:src).each do |r|
      next unless range.overlap?(r.src_range)

      res << (r.src - 1)
      res << r.dst

      break unless range.cover?(r.dst_end)

      res << r.dst_end
    end

    res << range.end unless res.count.even?

    res.each_slice(2).map { |a, b| a..b }
  end
end

seeds = maps[0][/seeds: \K.*/]
  .split
  .map(&:to_i)
  .each_slice(2).map { |start, len| start...(start + len) }
pp seeds

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

locs = seeds.flat_map { |s|
  maps2.reduce([s]) { |acc, val| pp acc; pp val; acc.flat_map { val.map_range(_1) } }
}
pp locs
