require 'sinatra'
require "sinatra/reloader"

# Run this script with `bundle exec ruby app.rb`
require 'active_record'

#require classes
# require './models/cake.rb'
require './models/post.rb'
require './models/user.rb'

# require './signup'
# require './login'
# require './pasta'
# require './gluten'
# require './vegan'
require "faker"

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'
require 'csv'

# Connect to a sqlite3 database
# If you feel like you need to reset it, simply delete the file sqlite makes



if ENV["DATABASE_URL"]
  require 'pg'
  ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
else
  require 'sqlite3'
  ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/rumblr.db'
  )

end


register Sinatra::Reloader
enable :sessions

get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    erb :index, :layout => :prime_layout
  else
    erb :index, :layout => :prime_layout
end
end

get '/homepage' do
  if session[:user_id]
    @test = Post.all
    @user = User.find(session[:user_id])
    erb :homepage, :layout => :prime_layout
  else
    erb :index, :layout => :prime_layout
  end
end

post "/create" do
  if session[:user_id]
    @user = User.find(session[:user_id])
    Post.create(user_id: session[:user_id], title: params["title"], summary: params["summary"])
    puts "wake up"
    # erb :homepage
    redirect '/feeds'
  else
    erb :index, :layout => :prime_layout
  end
  
end

get '/profile' do
  @user = User.find(session[:user_id])
  @allposts = Post.all.reverse
  erb :profile, :layout => :prime_layout
end

get '/feeds' do
  @user = User.find(session[:user_id])
  @allposts = Post.all.reverse
  erb :feeds, :layout => :prime_layout

end

get '/pasta' do
  erb :pasta, :layout => :prime_layout

end
get '/gluten' do
  erb :gluten, :layout => :prime_layout

end
get '/vegan' do
  erb :vegan, :layout => :prime_layout

end

get '/login' do
  erb :login, :layout => :prime_layout
end

post '/users/login' do
  user = User.find_by(email: params["email"], password: params["password"])
  puts ">>>>>>>>>>>>"
  puts user.inspect
  puts ">>>>>>>>>>>>"
  if user
    session[:user_id] = user.id
    redirect '/homepage'
  else
    redirect '/login'
  end
end

get '/signup' do
  erb :signup, :layout => :prime_layout
end

post '/users/signup' do
  temp_user = User.find_by(email: params["email"])
  if temp_user
    redirect '/login'
  else
    user = User.create(first_name: params["first_name"], last_name: params["last_name"],email: params["email"],  password: params["password"])
    session[:user_id] = user.id
    redirect '/'
  end
end

get '/account/delete/:id' do
  user_id = params[:id]
  user = User.find_by_id(user_id)
  user.posts.destroy_all
  User.find(session[:user_id]).destroy
  session[:user_id] = nil
  redirect '/login'
end

get '/logout' do
  session[:user_id] = nil
  redirect '/login'
end