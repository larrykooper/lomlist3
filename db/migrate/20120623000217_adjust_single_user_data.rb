class AdjustSingleUserData < ActiveRecord::Migration
  def up
    lkuser = User.find_by_email('larry.kooper@gmail.com')
    lkuserid = lkuser.id 
    ActType.update_all ["user_id = ?", lkuserid]
    Item.update_all ["user_id = ?", lkuserid]
    Tagging.update_all ["user_id = ?", lkuserid]
    Tag.update_all ["user_id = ?", lkuserid]  
  end

  def down
  end
end
