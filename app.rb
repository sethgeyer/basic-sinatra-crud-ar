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
    name = params[:username]
    word = params[:password]

    if params.values.include? ""
      flash[:notice] = if name == "" && word == ""
                        "Password and Username is required"
                       elsif name == ""
                        "Username is required"
                       elsif word == ""
                        "Password is required"
                       end
      redirect '/users/new'
    else
      if @database_connection.sql("INSERT INTO users (username, password) VALUES ('#{name}', '#{word}')")
        flash[:notice] = "Thank you for registering."
      end
      redirect "/"
    end
  end

  post "/login" do
    name = params[:username]
    word = params[:password]
    current_user = @database_connection.sql("SELECT * FROM users WHERE username= '#{name}'").first
    #p current_user
    session[:user_id] = current_user['id']
    flash[:notice] = "Welcome #{current_user["username"]}!"
    redirect "/"
  end

  get '/logout' do
    session.delete(:user_id)
    redirect "/"
  end

end
