# frozen_string_literal: true

require 'dry/cli'
require 'strscan'

module AoC
  module Day
    module CLI
      extend Dry::CLI::Registry

      def self.substitute(text, subs)
        s = StringScanner.new(text)
        res = String.new
        re = /#\s*aoc:\s*replace\s+/m

        return text unless s.exist?(re)

        until s.eos?
          s.scan_until(re)
          res << s.pre_match

          w = s.scan(/\w+/)
          res << subs[w]
        end
      end

      def self.copy_sub_file(source, target, subs)

      end

      def self.copy_substitute(source, target, subs, root: source)
        dir = Dir.new(source)
        FileUtils.mkdir_p(target)

        dir.each_child do |entry|
          src_path = File.join(source, entry)
          dst_path = File.join(target, entry)

          if File.file?(src_path)
            copy_sub_file(src_path, dst_path, subs)
          elsif File.dir?(src_path)
            FileUtils.mkdir_p(dst_path)
            copy_substitute(src_path, dst_path, subs, root:)
          else
            raise ArgumentError
          end
        end
      end

      class Begin < AoC::CLI::DayCommand
        desc 'Copy a template to the raw directory'

        def call(**)
          day, _ = super

          template = Dir.new(AoC::TEMPLATE_PATH)

          FileUtils.mkdir_p File.join(AoC::RAW_BASE, day.to_s)
        end
      end

      register 'begin', Begin, aliases: %w[b]
    end
  end
end
