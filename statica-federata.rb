#!/usr/bin/env ruby
require 'sinatra'

get '/' do
  "Hello"
end

get '/users/:actor' do
  "yolo #{params[:actor]}"
end
