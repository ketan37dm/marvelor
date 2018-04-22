module Marvelor
  module API
    class CharacterInfo < BaseInfo
      attr_accessor :options

      PER_PAGE = 30
      BASE_URL = '/v1/public/characters'

      def initialize(options = {})
        @options = options
      end

      def fetch_response
        self.class.get(url, params)
      end

      private

      def params
        options.merge!(pagination_params)
        { query: options }
      end

      def pagination_params
        params = { limit: options[:limit] || PER_PAGE }
        params.merge!({ offset: options[:offset] }) if options[:offset]
        params
      end

      def url
        [
          BASE_URL,
          options[:id]
        ].compact.join('/')
      end
    end
  end
end
