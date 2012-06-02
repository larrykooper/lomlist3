class CreateTaggings < ActiveRecord::Migration
  def up
     create_table :taggings do |t|      
        t.integer :tag_id
        t.integer :user_id
        t.timestamps
    end
  end

  def down
     drop_table :taggings 
  end
end
