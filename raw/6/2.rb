#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aoc'

DAY = 6

input = AoC::Input.read(DAY)
lines = AoC::Input.readlines(DAY)

Race = Data.define(:time, :distance)

r = lines.map { |l| l[/(\d+\s+)+/].split.join.to_i }
  .then { |time, distance| Race.new(time:, distance:) }

pp (0..r.time).count { |t| t * (r.time - t) > r.distance }
