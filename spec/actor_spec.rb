require './statica-federata.rb'
require 'rspec'
require 'rack/test'
require 'json'
require 'securerandom'
require './spec/shared-test-module.rb'

def save_actor storage, name, value
  storage["actor:#{name}"] = value
end

describe 'an actor' do
  include SharedTest

  before :all do
    @actor_name = 'mazin'

    @storage = Moneta.new :HashFile, dir: '.moneta/data'
    save_actor @storage, @actor_name, '{}'
  end

  describe '- get' do

    describe '- success -' do

      before :each do
        get "/users/#{@actor_name}"
        expect(last_response.status).to eq 200
        body = last_response.body
        @json = JSON.parse body
      end

      it 'has an id' do
        expect( @json['id'] ).to eq "https://mastodon.mazin.cc/users/#{@actor_name}"
      end

      it 'has a type' do
        expect( @json['type'] ).to eq 'weblog'
      end

      ['following', 'followers', 'inbox', 'outbox'].each do |action|
        it "has #{action}" do
          expect( @json[action] ).to eq "https://mastodon.mazin.cc/users/#{@actor_name}/#{action}"
        end
      end

    end

    it 'returns absence when it does not exist' do
      get "/users/non-existent-actor"
      expect(last_response.status).to eq 404
    end
  end

  describe 'gather a following' do

    before :each do
      @follower_actor_name = 'follower'
      save_actor @storage, @followee_actor_name, '{}'
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
        'object' => identifier_from(@actor_name)
      }
      inbox_url = get( "/users/#{@actor_name}" ).body['inbox']
      post inbox_url, body
    end
  end
end
