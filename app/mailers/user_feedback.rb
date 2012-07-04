class UserFeedback < ActionMailer::Base
  default from: "user-feedback@mydothis.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_feedback.feedback.subject
  #
  def feedback(feedback_message)
    @feedback_message = feedback_message
    mail to: "larry.kooper@gmail.com", from: feedback_message[:sender_email], subject: '[mydothis.com feedback] ' + feedback_message[:subject]
  end
end
