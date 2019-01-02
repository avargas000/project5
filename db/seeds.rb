User.create(first_name: "Fizal", last_name: "Sarif", password: "test1234", email: "fizal@nycda.com")
Post.create(title: "test", summary: "test1", date: "test2", user_id: 1)



if ENV["DATABASE_URL"]
    ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
  else
    ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/development.db'
    )
  
  end
  