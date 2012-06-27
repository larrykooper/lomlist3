class MakeMoreColsNotNullable < ActiveRecord::Migration
  def up
    change_column :items, :create_date, :datetime, :null => false
    change_column :items, :number, :integer, :null => false 
    change_column :items, :act_type, :string, :null => false 
    change_column :items, :item_desc, :text, :null => false 
    change_column :taggings, :tag_id, :integer, :null => false 
    change_column :tags, :name, :string, :null => false 
  end

  def down
  end
end
