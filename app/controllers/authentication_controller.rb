class AuthenticationController < ApplicationController
  def login
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password]) && user&.validated_email
      render json: user, serializer: User::UserSerializer, status: 200
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def login_google
    user = User.where('email_gg = ? AND id_gg = ?', params[:email_gg], params[:id_gg]).first
    if user && user.token_gg == params[:token_gg]
      render json: user, serializer: User::UserGoogleSerializer, status: 200
    else
      user = User.new(login_params_google)
      user[:first_names] = params[:name_gg]
      user[:email_gg] = params[:email_gg]
      user[:password_digest] = 'google-auth account' # fake passworkd for login google
      if user.valid? && user.save
        render json: user, serializer: User::UserGoogleSerializer, status: 200
      else
        render json: { error: user.errors.messages }, status: 422
      end
    end
  end

  def login_facebook
    user = User.where('email_fb = ? AND id_fb = ?', params[:email_fb], params[:id_fb]).first
    if user && user.token_fb == params[:token_fb]
      render json: user, serializer: User::UserGoogleSerializer, status: 200
    else
      user = User.new(login_params_facebook)
      user[:first_names] = params[:name_fb]
      user[:email_fb] = params[:email_fb]
      user[:password_digest] = 'facebook-auth account' # fake passworkd for login google
      if user.valid? && user.save
        render json: user, serializer: User::UserFacebookSerializer, status: 200
      else
        render json: { error: user.errors.messages }, status: 422
      end
    end
  end

  private

  def login_params_google
    params.permit(:id_gg, :email_gg, :token_gg)
  end

  def login_params_facebook
    params.permit(:id_fb, :email_fb, :token_fb)
  end
end
