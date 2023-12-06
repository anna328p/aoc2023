#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aoc'

DAY = 6

input = AoC::Input.read(DAY)
lines = AoC::Input.readlines(DAY)

Race = Data.define(:time, :distance)

races = lines.map { |l| l[/(\d+\s+)+/].split.map(&:to_i) }
  .then { |times, distances|
    times.zip(distances).map { |time, distance| Race.new(time:, distance:) }
  }

pp races.map { |r|
  (0..r.time).count { |t| t * (r.time - t) > r.distance }
}.inject(:*)
