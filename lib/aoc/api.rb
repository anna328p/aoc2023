# frozen_string_literal: true

module AoC
  module API
    def self.session_cookie
      ENV['AOC_SESSION_COOKIE'] || raise('Session cookie not found')
    end

    def self.input_uri(day)
      str = URI.join(AoC::URI_BASE, "day/#{day}/input")

      URI(str)
    end

    def self.fetch_input(day)
      uri = input_uri(day)

      Net::HTTP.get(uri, { Cookie: API.session_cookie })
    end
  end
end
