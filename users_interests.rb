require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @users_data = YAML.load_file("data/users.yaml")
  @users = @users_data.keys
end

helpers do
  def count_interests
    interests = @users.each_with_object([]) do |user, array|
      array << @users_data[user][:interests]
      array.flatten!
    end
    interests.size
  end
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :user_directory
end

get "/users/:user" do
  @username = params[:user]
  @email = @users_data[@username.to_sym][:email]
  @interests = @users_data[@username.to_sym][:interests]
  
  erb :user_profile
end
