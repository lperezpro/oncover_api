# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  first_names            :string
#  last_names             :string
#  phone_number           :integer
#  date_birth             :date
#  document_id            :string
#  gender                 :integer
#  email                  :string
#  password_digest        :string
#  id_gg                  :string
#  email_gg               :string
#  token_gg               :string
#  id_fb                  :string
#  email_fb               :string
#  token_fb               :string
#  last_login             :datetime
#  validated_email        :boolean          default(FALSE)
#  email_token            :string
#  email_token_sent_at    :datetime
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  last_reset_password    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  enum gender: { male: 0, female: 1, other: 2 }
  has_secure_password
  # mount_uploader :avatar, AvatarUploader
  validates :email, uniqueness: true, if: -> { !document_id.nil? }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: -> { !email.nil? }
  validates :first_names, presence: true
  validates :document_id, uniqueness: true, if: -> { !document_id.nil? }
  validates :password,
            length: { minimum: 6 },
            if: -> { !password.nil? }
  validates :email_gg, format: { with: URI::MailTo::EMAIL_REGEXP }, if: -> { !email_gg.nil? }
  validates :email_fb, format: { with: URI::MailTo::EMAIL_REGEXP }, if: -> { !email_fb.nil? }

  def user_validate_account
    generate_email_token
    UserMailer.user_validate_account(self).deliver_now
  end

  def generate_email_token
    update(email_token: generate_token, email_token_sent_at: Time.now.utc)
  end

  def email_validation_token_valid?
    (email_token_sent_at + 4.hours) > Time.now.utc
  end

  def send_email_reset_password
    generate_password_token!
    UserMailer.password_reset_email(self).deliver_now
  end

  def generate_password_token!
    update(reset_password_token: generate_token, reset_password_sent_at: Time.now.utc)
  end

  def password_token_valid?
    (reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    update(reset_password_token: nil, reset_password_sent_at: nil, password: password, last_reset_password: Time.now.utc)
  end

  private

  # genera tokens
  def generate_token
    SecureRandom.hex(10)
  end

end
