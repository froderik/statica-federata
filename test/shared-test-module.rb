require 'rack/test'

module SharedTest
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end
