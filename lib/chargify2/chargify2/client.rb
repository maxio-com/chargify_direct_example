module Chargify2
  class Client
    URI = "https://api.chargify.com"
    
    attr_reader :api_id
    attr_reader :api_password
    attr_reader :api_secret

    def initialize(options = {})
      @api_id = options[:api_id] || options['api_id']
      @api_password = options[:api_password] || options['api_password']
      @api_secret = options[:api_secret] || options['api_secret']
    end
    
    def direct
      @direct ||= Direct.new(self)
    end
    
    def results
      Result.new("#{URI}/results")
    end
  end
end