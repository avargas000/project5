require 'sinatra'
require "sinatra/reloader"

# Run this script with `bundle exec ruby app.rb`
require 'sqlite3'
require 'active_record'

#require classes
# require './models/cake.rb'
require './models/post.rb'
require './models/user.rb'
require "faker"

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'
require 'csv'

# Connect to a sqlite3 database
# If you feel like you need to reset it, simply delete the file sqlite makes
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/rumblr.db'
)

register Sinatra::Reloader
enable :sessions

get '/' do

    erb :index, :layout => :prime_layout
  
end


get '/login.erb' do
  erb :login, :layout => :prime_layout
end

post '/users/login' do
  user = User.find_by(email: params["email"], password: params["password"])
  puts ">>>>>>>>>>>>"
  puts user.inspect
  puts ">>>>>>>>>>>>"
  if user
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/login'
  end
end

get '/signup.erb' do
  erb :signup, :layout => :prime_layout
end

post '/users/signup' do
  temp_user = User.find_by(email: params["email"])
  if temp_user
    redirect '/login'
  else
    user = User.create(firstName: params["first_name"], lastName: params["lasst_name"],email: params["email"],  password: params["password"])
    session[:user_id] = user.id
    redirect '/'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/login'
end