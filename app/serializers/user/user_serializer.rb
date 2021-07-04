class User::UserSerializer < ActiveModel::Serializer
  def attributes(*)
    time = Time.now + 24.hours.to_i
    {
      id: object.id,
      first_names: object.first_names,
      email: object.email,
      token: JsonWebToken.encode({user_id: object.id, created_at: Time.now }),
      exp: time.strftime("%m-%d-%Y %H:%M"),
      type_login: 'email'
    }
  end
end