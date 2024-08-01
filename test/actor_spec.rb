require './statica-federata.rb'
require 'test/spec'
require 'rack/test'
require 'json'

describe 'getting an actor' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before :all do
    get '/users/mazin'
    last_response.should.be.ok
    body = last_response.body
    @json = JSON.parse body
  end

  it 'has an id' do
    @json['id'].should.equal 'https://mastodon.mazin.cc/users/mazin'
  end
end
