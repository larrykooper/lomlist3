class FeedbackMessage   
  attr_accessor :subject, :user_question, :sender_email 
  
  def initialize(subject, user_question, sender_email)
    @subject = subject 
    @user_question = user_question
    @sender_email = sender_email 
  end  
  
end