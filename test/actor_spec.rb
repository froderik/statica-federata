require './statica-federata.rb'
require 'test/spec'
require 'rack/test'

describe 'actor' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'returns an actor' do
    get '/users/mazin'
    last_response.should.be.ok
    last_response.body.should.equal 'yolo mazin'
  end
end
