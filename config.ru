require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'omniauth-twitcasting'

class CasSinatraSandbox < Sinatra::Base
  use Rack::Session::Cookie

  get '/' do
    redirect '/auth/twitcasting'
  end

  get '/auth/:provider/callback' do
    content_type 'text/plain'
    request.env['omniauth.auth'].to_hash.inspect rescue "No Data"
  end

  get '/auth/failure' do
    content_type 'text/plain'
    request.env['omniauth.auth'].to_hash.inspect rescue "No Data"
  end

  use OmniAuth::Builder do
    provider OmniAuth::Strategies::Twitcasting, ENV["TWITCASTING_API_CLIENT_ID"], ENV["TWITCASTING_API_CLIENT_SECRET"]
  end
end

run CasSinatraSandbox.run!
