require 'sinatra'
require 'cgi'

get '/' do
  erb :index
end

get '/signup/:plan' do
  if params[:plan].nil?
    redirect to("/?message=#{CGI.escape(%{No plan selected})}")
  elsif ['small', 'medium', 'large'].include?(params[:plan])
    erb :signup
  else
    redirect to("/?message=#{CGI.escape(%{There is no plan called "#{params[:plan].capitalize}"})}")
  end
end

post '/verify' do
  erb :verify
end

not_found do
  "Not found"
end