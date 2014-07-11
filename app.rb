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
    all_fish = @database_connection.sql("SELECT * FROM fishes WHERE user_id=#{session[:user_id].to_i}")

    erb :home, locals: {all_users: all_users, all_fish: all_fish}
  end

  get "/order/:order" do
    if params[:order] == "ascending"
      order = "ASC"
    elsif params[:order] == "descending"
      order = "DESC"
    else
      redirect "/"
    end
    all_users = @database_connection.sql("SELECT * FROM users WHERE id != #{session[:user_id].to_i} ORDER BY username #{order}")
    all_fish = @database_connection.sql("SELECT * FROM fishes  WHERE user_id=#{session[:user_id].to_i}")
    erb :home, locals: {all_users: all_users, all_fish: all_fish}
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
      begin
        @database_connection.sql("INSERT INTO users (username, password) VALUES ('#{name}', '#{word}')")
        flash[:notice] = "Thank you for registering."
        redirect "/"
      rescue
        flash[:notice] = "Username is already taken"
        redirect '/users/new'
      end

    end
  end


  get "/add_fish" do
    erb :new_fish
  end

  post "/add_fish" do
    name = params[:name]
    url = params[:url]
    user_id = session[:user_id].to_i
    @database_connection.sql("INSERT INTO fishes (name, url, user_id) VALUES ('#{name}', '#{url}', #{user_id})")

    redirect "/"
  end

  get "/delete/:name" do
    name = params[:name]
    @database_connection.sql("DELETE FROM users WHERE username='#{name}'")
    redirect "/"
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
