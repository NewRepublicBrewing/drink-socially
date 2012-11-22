require 'drink-socially/http_service'
require 'drink-socially/version'
require 'drink-socially/helpers/symbolifer'

module NRB
  module Untappd

    autoload :API,       'drink-socially/api'
    autoload :APIObject, 'drink-socially/api_object'
    autoload :Checkin,   'drink-socially/checkin'
    autoload :User,      'drink-socially/user'

    class << self
      attr_accessor :http_service

      def http_service=(service) 
        @http_service = service
      end


      def make_request(verb, path, args={})
        http_service.make_request verb, path, args
      end

    end

    self.http_service = HTTPService

  end
end
