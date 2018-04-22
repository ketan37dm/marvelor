class InvalidClient < StandardError; end

module Marvelor
  module API
    class Client
      attr_reader :public_key, :private_key

      def initialize(attributes)
        raise InvalidClient, 'Public Key and Private Key are required' if attributes[:public_key].nil? || attributes[:private_key].nil?
        @public_key = attributes.fetch(:public_key)
        @private_key = attributes.fetch(:private_key)
      end

      # Valid options are -
      #   limit - number of records to fetch
      #   offset - number of records to be skipped
      #   name - name of the character
      #   id - ID of the character
      def characters(options = {})
        options.merge!(base_params)
        CharacterInfo.new(options).fetch_response
      end

      private

      def base_params
        {
          apikey: public_key,
          ts: time_stamp,
          hash: hash_value
        }
      end

      def time_stamp
        Time.now.to_i
      end

      def hash_value
        Digest::MD5.hexdigest("#{time_stamp}#{private_key}#{public_key}")
      end
    end
  end
end
