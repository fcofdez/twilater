module Readability

  # Given a block with api_key configures
  # api consumer
  module Configuration
    attr_accessor :api_key

    def configure
      yield self
    end
  end

  # Use Mash to get hash as an objet and handle
  # better on application
  class Mashify < Faraday::Response::Middleware
    def on_complete(env)
      super if Hash === env[:body]
    end

    def parse(body)
      Hashie::Mash.new(body)
    end
  end

  module Connection
    def connection
      @connection ||= begin
                        conn = Faraday.new('https://readability.com/api/content/v1/') do |c|

                          c.response :mashify
                          c.response :json, content_type: 'application/json'
                          c.use Faraday::Response::Logger,          Logger.new('log/faraday.log')
                          c.use FaradayMiddleware::FollowRedirects, limit: 3
                          c.use Faraday::Response::RaiseError       # raise exceptions on 40x, 50x responses
                          c.use Faraday::Adapter::NetHttp
                        end

                        conn.params['token'] = api_key
                        conn
                      end
    end

    def get(path, params = nil)
      connection.get(path) do |request|
        request.params.update(params) if params
      end
    end
  end

  module ApiMethods
    def get(path, params = nil)
      raw = params && params.delete(:raw)
      response = super
      raw ? response.env[:raw_body] : response.body
    end

    def parse_url(url)
      get("parser", url: url)
    end
  end

  extend Configuration
  extend Connection
  extend ApiMethods
end

