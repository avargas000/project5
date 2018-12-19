
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
  database: './db/rumblr.db'
)

binding.pry