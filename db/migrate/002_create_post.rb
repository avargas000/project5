class CreatPost < ActiveRecord::Migration[5.0]
    def up
      create_table :post do |t|
        t.string :title
        t.string :summary
        t.string :date
        
      end
    end

  def down
    drop_table :post
  end
end