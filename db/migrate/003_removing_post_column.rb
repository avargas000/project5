class RemovingPostColumn < ActiveRecord::Migration[5.0]
    def up
      remove_column(:posts, :image)
      remove_column(:posts, :date)
      
    end

  def down
    drop_table :posts
  end
end