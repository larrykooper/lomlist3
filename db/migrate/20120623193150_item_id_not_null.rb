class ItemIdNotNull < ActiveRecord::Migration
  def up
     change_column :taggings, :item_id, :integer, :null => false
  end

  def down
  end
end
