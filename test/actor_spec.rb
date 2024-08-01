require './statica-federata.rb'
require 'test/spec'
require 'rack/test'
require 'json'

describe 'getting an actor' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before :each do
    @actor_name = 'mazin'
    get "/users/#{@actor_name}"
    last_response.should.be.ok
    body = last_response.body
    @json = JSON.parse body
  end

  it 'has an id' do
    @json['id'].should.equal "https://mastodon.mazin.cc/users/#{@actor_name}"
  end

  ['following', 'followers', 'inbox', 'outbox'].each do |action|
    it "has #{action}" do
      @json[action].should.equal "https://mastodon.mazin.cc/users/#{@actor_name}/#{action}"
    end
  end
end
