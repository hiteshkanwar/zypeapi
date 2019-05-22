module Zype
  class BaseClass
    def initialize options={}
    end

    protected
    def end_point
      @end_point ||= ENV.fetch('ZYPE_END_POINT')
    end
    def app_key
      @app_key ||= ENV.fetch('ZYPE_APP_KEY')
    end

    def rest_api(verb, path, options={})
      args = [end_point + path]

      args[0] += "?app_key=#{app_key}"
      if options[:params]
        params = options[:params]
        params.keys.each do |key|
          args[0] += "&#{key.to_s}=#{params[key]}"
        end
      end

      if options[:data]
        data = options[:data]
        if verb.in?(%i[ post put patch ])
          args << data.compact.to_json
          args << { 'Content-Type' => 'application/json' }
        else
          args << data.compact
          args << {}
        end
      else
        args << nil
        args << {}
      end

      args.last['Accept']   = 'application/json'

      response = ::Faraday.send(verb, *args)
      JSON.parse(response.body)
    end
  end
end
