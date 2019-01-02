require "faker"

user_collection = Volt.current_app.store.users

10.times do |num|
  .create(email: Faker::Internet.email,
          password: "coding123",
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          posts: Faker::Lorem.sentence)
          .then {|user| puts "added user ## {num}. #{user.name}"}
          .fail {|error| puts "failed to add user ## {num}. #{error}"}

end


if ENV["DATABASE_URL"]
  require 'pg'
    ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
  else
    require 'sqlite3'
    ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/development.db'
    )
  
  end
  