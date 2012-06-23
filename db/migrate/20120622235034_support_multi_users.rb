class SupportMultiUsers < ActiveRecord::Migration
  def up
    add_column :act_types, :user_id, :integer 
    add_column :items, :user_id, :integer 
    add_column :taggings, :user_id, :integer 
    add_column :tags, :user_id, :integer 
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end

  def down
    remove_column :act_types, :user_id
    remove_column :items, :user_id
    remove_column :taggings, :user_id
    remove_column :tags, :user_id
  end
end
