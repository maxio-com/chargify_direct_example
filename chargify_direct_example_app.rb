require 'yaml'
require 'securerandom'

class ChargifyDirectExampleApp < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/verify' do
    if chargify.direct.response_parameters(params).verified?
      @call = chargify.calls.read(params[:call_id])

      if @call.successful?
        redirect "/receipt/#{@call.id}"
      else
        erb :index
      end
    else # Unverified redirect
      erb :unverified
    end
  end

  get '/update_card/verify/:original_call_id' do
    if chargify.direct.response_parameters(params).verified?
      @call = chargify.calls.read(params[:call_id])

      if @call.successful?
        redirect "/receipt/#{params[:original_call_id]}"
      else
        erb :update_card
      end
    else # Unverified redirect
      erb :unverified
    end
  end

  get '/receipt/:call_id' do
    @call = chargify.calls.read(params[:call_id])
    if @call
      erb :receipt
    else
      not_found
    end
  end

  get '/update_card/:subscription_id/:call_id' do
    erb :update_card
  end

  not_found do
    "Not found"
  end

  helpers do
    def root_url
      "#{request.scheme}://#{request.host_with_port}"
    end

    def chargify
      @chargify ||= Chargify2::Client.new(config)
    end
  
    def config
      @config ||= YAML.load(File.open(config_file)) || {}
    end
  
    def config_file
      File.expand_path File.join(File.dirname(__FILE__), 'config', 'config.yml')
    end
  
    def h(s)
      Rack::Utils.escape_html(s)
    end
  
    def original_params
      if @call
        @call.request
      else
        OpenCascade.new
      end
    end
  end
end
