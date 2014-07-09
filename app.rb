require "sinatra"
require "active_record"
require "./lib/database_connection"
require "rack-flash"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash
  def initialize
    super
    @database_connection = DatabaseConnection.new(ENV["RACK_ENV"])
  end

  get "/" do
    erb :home
  end

  get "/users/new" do
    erb :new_user
  end

  post "/users" do
    flash[:notice] = "Thank you for registering."
    redirect "/"#,
  end

end
