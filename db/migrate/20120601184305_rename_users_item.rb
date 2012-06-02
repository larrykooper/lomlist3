class RenameUsersItem < ActiveRecord::Migration
  def up
    rename_column :taggings, :user_id, :item_id
  end

  def down
  end
end
