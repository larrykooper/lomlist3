class DeviseInvitableAddToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string   :invitation_token,     :limit => 60
      t.datetime :invitation_sent_at
      t.index    :invitation_token
      t.integer  :invitation_limit,  :default => 0, :null => true
      t.integer  :invited_by_id
      t.string   :invited_by_type
    end
    
    # And allow null encrypted_password and password_salt:
    change_column :users, :encrypted_password, :string, :null => true     
    
    lkuser = User.find_by_email('larry.kooper@gmail.com')
    lkuser.update_attribute(:invitation_limit, nil)
      
  end

  def down
    remove_column :users, :invited_by_type
    remove_column :users, :invited_by_id
    remove_column :users, :invitation_limit
    remove_column :users, :invitation_sent_at
    remove_column :users, :invitation_token
  end
end


