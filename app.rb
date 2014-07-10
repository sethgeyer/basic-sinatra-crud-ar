require "sinatra"
require "active_record"
require "./lib/database_connection"
require "rack-flash"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash
  def initialize
    super
    @database_connection = DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    all_users = @database_connection.sql("SELECT * FROM users WHERE id != #{session[:user_id].to_i}")
    erb :home, locals: {all_users: all_users}
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
    # elsif @database_connection.sql("SELECT * FROM users WHERE username='#{name}'") != []
    #    flash[:notice] = "Username is already taken"
    #    redirect '/users/new'
    else
      #begin
        @database_connection.sql("INSERT INTO users (username, password) VALUES ('#{name}', '#{word}')")
        flash[:notice] = "Thank you for registering."
        redirect "/"
      # rescue
      #   flash[:notice] = "Username is already taken"
      #   redirect '/users/new'
      #end

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
