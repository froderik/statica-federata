require 'rack/test'
require 'webmock/rspec'
require 'rspec'


module SharedTest
end

RSpec.configure do |config|
  include Rack::Test::Methods

  config.full_backtrace = true

  def app
    Sinatra::Application
  end
end
