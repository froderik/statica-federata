#!/usr/bin/env ruby
require 'sinatra'
require 'moneta'
require 'rest-client'
require 'json'

configure do
  set(:moneta_store) do
    Moneta.new :HashFile, dir: '.moneta/data'
  end

  enable :logging
  set :show_exceptions, false
end

get '/' do
  "Hello"
end

get '/users/:actor' do
  actor_name = params[:actor]
  actor = settings.moneta_store["actor:#{actor_name}"]

  unless actor
    not_found { 'Actor not found'  }
  end

  response = {
    id: "https://mastodon.mazin.cc/users/#{params[:actor]}",
    type: 'weblog',
    followers: "https://mastodon.mazin.cc/users/#{params[:actor]}/followers",
    following: "https://mastodon.mazin.cc/users/#{params[:actor]}/following",
    inbox: "https://mastodon.mazin.cc/users/#{params[:actor]}/inbox",
    outbox: "https://mastodon.mazin.cc/users/#{params[:actor]}/outbox",
  }
  JSON.generate(response)
end

post '/users/:actor/inbox' do
  request.body.rewind
  data = JSON.parse request.body.read
  follow_accept_body = {
    type: 'Accept',
    actor: "https://mastodon.mazin.cc/users/#{params[:actor]}",
    object: {
      id: "#{data['id']}"
    }
  }
  accept_return = RestClient.post "https://follower.domain.mastodon/users/follower/inbox", JSON.generate(follow_accept_body)
  JSON.generate accept_return
end

error do
  'Sadness like this: ' + env['sinatra.error'].message
end
