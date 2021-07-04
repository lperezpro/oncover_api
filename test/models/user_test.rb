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
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
