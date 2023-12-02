# frozen_string_literal: true

require 'dry/cli'

module AoC
  module CLI
    class DayCommand < Dry::CLI::Command
      argument :day, required: true

      def call(day:, **)
        day = Integer(day)

        dir = Input.input_dir(day)

        [day, dir]
      rescue ArgumentError => e
        warn "Could not parse day: #{e.message}"
        exit 1
      end
    end
  end
end
