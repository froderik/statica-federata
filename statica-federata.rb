#!/usr/bin/env ruby
require 'sinatra'

get '/' do
  "Hello"
end

get '/users/:actor' do
  response = {'id': "https://mastodon.mazin.cc/users/#{params[:actor]}" }
  JSON.generate(response)
end
