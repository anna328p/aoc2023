# frozen_string_literal: true

require 'dry/cli'
require 'net/http'
require 'fileutils'

module AoC
  module Input
    module CLI
      extend Dry::CLI::Registry

      class Get < AoC::CLI::DayCommand
        desc 'Download the input for a given day'

        def call(**)
          day, dir = super
          path = Input.input_path(day)

          input = API.fetch_input(day)

          FileUtils.mkdir_p dir
          File.write path, input

          puts path
        end
      end

      class Edit < AoC::CLI::DayCommand
        desc 'Edit an input for a given day'

        argument :name, default: 'input.txt',
          desc: 'Name of the specific input to edit; defaults to "input.txt"'

        argument :rest, type: :array, required: false,
          desc: 'Arguments to pass through to the editor'

        def call(name:, rest: [], **)
          _, dir = super
          path = File.join(dir, name)

          vi = ENV.fetch('VISUAL', 'nvim')

          system(vi, path, *rest)
        end
      end

      register 'get', Get, aliases: %w[g]
      register 'edit', Edit, aliases: %w[e]
    end
  end
end
