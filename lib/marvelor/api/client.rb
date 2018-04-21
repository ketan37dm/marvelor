class InvalidClient < StandardError; end

module Marvelor
  module API
    class Client
      def initialize(attributes)
        raise InvalidClient, 'Public Key and Private Key are required' if attributes[:public_key].nil? || attributes[:private_key].nil?
        @public_key = attributes.fetch(:public_key)
        @private_key = attributes.fetch(:private_key)
      end
    end
  end
end
