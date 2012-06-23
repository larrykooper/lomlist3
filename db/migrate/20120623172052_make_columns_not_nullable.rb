class MakeColumnsNotNullable < ActiveRecord::Migration
  def up
    change_column :act_types, :user_id, :integer, :null => false
    change_column :items, :user_id, :integer, :null => false
    change_column :taggings, :user_id, :integer, :null => false
    change_column :tags, :user_id, :integer, :null => false
  end

  def down
  end
end
