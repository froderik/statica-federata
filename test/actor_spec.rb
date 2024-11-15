require './statica-federata.rb'
require 'test/spec'
require 'rack/test'
require 'json'
require 'securerandom'
require './test/shared-test-module.rb'

describe 'getting an actor' do
  include SharedTest

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

  it 'has a type' do
    @json['type'].should.equal 'weblog'
  end

  ['following', 'followers', 'inbox', 'outbox'].each do |action|
    it "has #{action}" do
      @json[action].should.equal "https://mastodon.mazin.cc/users/#{@actor_name}/#{action}"
    end
  end
end

describe 'following an actor' do
  include SharedTest

  before :each do
    @followee_actor_name = 'followee'
    @follower_actor_name = 'follower'
  end

  def domain
    "https://mastodon.mazin.cc"
  end

  def identifier_from actor_name
    "#{domain}/users/#{actor_name}"
  end

  def random_activity_id
    "#{domain}/#{SecureRandom.uuid}"
  end

  it 'follows' do
    body = {
      'type' => 'Follow',
      'id' => random_activity_id,
      'actor' => identifier_from(@follower_actor_name),
      'object' => identifier_from(@followee_actor_name)
    }
    inbox_url = get( "/users/#{@followee_actor_name}" ).body['inbox']
    post inbox_url, body
  end
end
