require 'sinatra'
require 'yaml'

require 'chargify2'

get '/' do
  erb :index
end

get '/verify' do
  if chargify.direct.result(params).verified?
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

not_found do
  "Not found"
end

helpers do
  def chargify
    @chargify ||= Chargify2::Client.new(:api_id => config['api_id'], :api_password => config['api_password'], :api_secret => config['api_secret'], :base_uri => "http://app.chargify.local/api/v2")
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
