#!/usr/bin/env ruby
# frozen_string_literal: true

require 'aoc'

DAY = 7

Hand = Data.define(:cards, :bid) do
  CARDS = %w[A K Q J T 9 8 7 6 5 4 3 2].reverse.each_with_index.to_h.freeze

  TYPES = %i[
    high_card one_pair two_pair three_of_a_kind
    full_house four_of_a_kind five_of_a_kind
  ].each_with_index.to_h.freeze

  def self.parse(line)
    a, b = line.split
    new(a.chars, b.to_i)
  end

  def type
    t = cards.tally

    case t.values.sort
    when [5]
      :five_of_a_kind
    when [1, 4]
      :four_of_a_kind
    when [2, 3]
      :full_house
    when [1, 1, 3]
      :three_of_a_kind
    when [1, 2, 2]
      :two_pair
    when [1, 1, 1, 2]
      :one_pair
    else
      :high_card
    end
  end

  def <=>(other)
    res = TYPES[type] <=> TYPES[other.type]
    return res unless res == 0

    cards.zip(other.cards).each do |ca, cb|
      res = CARDS[ca] <=> CARDS[cb]
      return res unless res == 0
    end
  end
end

input = AoC::Input.readlines(DAY).map { Hand.parse _1 }

res = input.sort.each_with_index.map { |val, idx| (idx + 1) * val.bid }.sum

puts res
