class UserMailer < ApplicationMailer
  before_action :set_global_params

  def user_validate_account(user)
    RestClient.post @url,
                    from: 'info@oncover.com',
                    to: user.email,
                    subject: 'Confirm user',
                    template: 'confirm-mail-oncover',
                    'v:url_confirmation': "https://localhost:8080/confirm-user?token=#{user.email_token}",
                    'v:enterprise': 'On cover apps'
  end

  def password_reset_email(user)
    RestClient.post @url,
                    from: 'info@oncover.com',
                    to: user.email,
                    subject: 'Confirm user',
                    template: 'reset-password',
                    'v:link_reset_password': "https://localhost:8080/reset_password?token=#{user.reset_password_token}"
  end
end
