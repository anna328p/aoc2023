# frozen_string_literal: true

require 'pathname'

module AoC
  YEAR = 2023

  URI_BASE = "https://adventofcode.com/#{YEAR}/"

  DIR_BASE = Pathname.new(File.join(__dir__, '..', '..')).cleanpath

  INPUT_BASE = File.join(DIR_BASE, 'inputs')
  TEMPLATE_PATH = File.join(DIR_BASE, 'template')
  RAW_BASE = File.join(DIR_BASE, 'raw')
  CLEAN_BASE = File.join(DIR_BASE, 'clean')
end
