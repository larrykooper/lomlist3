class Users::InvitationsController < Devise::InvitationsController
  
  def create 
    super 
    self.resource.invitation_limit = self.resource.class.invitation_limit
    self.resource.save
  end
  
end
