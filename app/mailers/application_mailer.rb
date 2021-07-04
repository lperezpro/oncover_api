class ApplicationMailer < ActionMailer::Base
  default from: 'no_responder@oncover.com'
  layout 'mailer'

  private 

  def set_global_params
    @tags = ['oncover']
    if Rails.env === 'development'
      @url = "https://api:#{Rails.application.secrets[:mg][:api_key]}"\
      "@api.mailgun.net/v3/#{Rails.application.secrets[:mg][:domain]}/messages"
      @tags << 'test'
		elsif Rails.env === 'develop'
      @url = ''
      @tags << 'develop'
		else
      @url = ''
    end
  end
end
