require 'rack/test'

module SharedTest
end

RSpec.configure do |config|
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end
