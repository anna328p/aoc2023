# frozen_string_literal: true

module AoC
  module Input
    def self.input_dir(day)
      File.join(AoC::INPUT_BASE, day.to_s)
    end

    def self.input_path(day)
      dir = input_dir(day)
      File.join(dir, 'input.txt')
    end

    def self.read(day)
      File.read(input_path(day))
    end

    def self.readlines(day)
      File.readlines(input_path(day))
    end
  end
end
