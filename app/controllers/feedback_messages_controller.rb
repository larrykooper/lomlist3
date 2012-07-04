class FeedbackMessagesController < ApplicationController
  before_filter :authenticate_user!
  def send_message    
    UserFeedback.feedback(params).deliver
    render :nothing => true
  end
end