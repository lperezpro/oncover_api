class User::UserGoogleSerializer < ActiveModel::Serializer
  def attributes(*)
    time = Time.now + 24.hours.to_i
    {
      id: object.id,
      first_names: object.first_names,
      email: object.email_gg,
      token: JsonWebToken.encode({user_id: object.id, created_at: Time.now }),
      exp: time.strftime("%m-%d-%Y %H:%M"),
      type_login: 'google'
    }
  end
end
