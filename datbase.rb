
# Run this script with `bundle exec ruby app.rb`
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

binding.pry