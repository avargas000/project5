class CreatePost < ActiveRecord::Migration[5.0]
    def up
      create_table :posts do |t|
        t.integer :user_id
        t.string :title
        t.string :summary
        t.string :date
        t.string :image
      end
    end

  def down
    drop_table :posts
  end
end