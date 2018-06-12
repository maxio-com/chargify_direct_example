require 'yaml'

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

  get '/receipt/:call_id' do
    @call = chargify.calls.read(params[:call_id])
    if @call
      erb :receipt
    else
      not_found
    end
  end

  get '/card_update/:subscription_id' do
    @subscription_id = params[:subscription_id]
    erb :card_update
  end

  get '/verify_card_update' do
    if chargify.direct.response_parameters(params).verified?
      @call = chargify.calls.read(params[:call_id])

      if @call.successful?
        redirect "/card_update_receipt/#{@call.id}"
      else
        @subscription_id = chargify.calls.read(params[:call_id]).request.id
        erb :card_update
      end
    else # Unverified redirect
      erb :unverified_card_update
    end
  end

  get '/card_update_receipt/:call_id' do
    @call = chargify.calls.read(params[:call_id])
    if @call
      erb :card_update_receipt
    else
      not_found
    end
  end

  not_found do
    "Not found"
  end

  helpers do
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

    def signup_params
      @call ? @call.request.signup : nil
    end

    def product_params
      signup_params ? signup_params.product : {}
    end

    def coupon_code
      signup_params ? signup_params[:coupon_code] : nil
    end

    def customer_params
      signup_params ? signup_params.customer : {}
    end

    def payment_profile_params
      signup_params ? signup_params.payment_profile : {}
    end
  end
end
