#!/usr/bin/env ruby
require 'sinatra'

get '/' do
  "Hello"
end

get '/users/:actor' do
  response = {
    'id': "https://mastodon.mazin.cc/users/#{params[:actor]}",
    'type': 'weblog',
    'followers':  "https://mastodon.mazin.cc/users/#{params[:actor]}/followers",
    'following':  "https://mastodon.mazin.cc/users/#{params[:actor]}/following",
    'inbox':  "https://mastodon.mazin.cc/users/#{params[:actor]}/inbox",
    'outbox':  "https://mastodon.mazin.cc/users/#{params[:actor]}/outbox",
  }
  JSON.generate(response)
end

post '/users/:actor/inbox' do
  "yolo"
end
