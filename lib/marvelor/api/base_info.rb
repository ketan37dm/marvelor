module Marvelor
  module API
    class BaseInfo
      include HTTParty
      base_uri 'http://gateway.marvel.com'
    end
  end
end
