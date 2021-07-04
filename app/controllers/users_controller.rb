class UsersController < ApplicationController
  before_action :authorize_request, except: %i[create confirmation_user forgot_password reset_password]
  before_action :find_user, except: %i[create index confirmation_user forgot_password reset_password]

  # GET /users
  def index
    users = User.all
    render json: users, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    user = User.new(user_params)
    if user.save
      user.user_validate_account
      render json: user, status: 200
    else
      render json: { errors: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  # confirmation user with token code from mail
  def confirmation_user
    user = User.where('email_token = ?', params[:token]).first
    if user.present? && user.email_validation_token_valid?
      render json: { status: 'ok' }, status: 200 if user.update(validated_email: true, email_token: nil,
                                                                email_token_sent_at: nil)
    else
      render json: { messages: [I18n.t('errors.confirmation_link_invalid')] }, status: 400
    end
  end

  def forgot_password
    return render json: { messages: ['Email not present'] }, status: 400 if params[:email].blank?

    user = User.where('email = ?', params[:email]).first
    if user.present?
      user.send_email_reset_password
      render json: { status: 'ok' }, status: 200
    else
      render json: { messages: ['Email address not found. Please check and try again.'] }, status: 404
    end
  end

  def reset_password
    token = params[:token].to_s

    return render json: { messages: ['Token not present'] }, status: 400 if params[:token].blank?

    user = User.where('reset_password_token = ?', token).first

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: { status: 'ok' }, status: 200
      else
        render json: { messages: user.errors.full_messages }, status: 400
      end
    else
      render json: { messages: ['Link not valid or expired. Try generating a new link.'] }, status: 422
    end
  end

  private

  def find_user
    @user = User.find_by_id!(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :first_names, :last_names, :phone_number, :date_birth, :email, :document_id, :gender,
      :password, :password_confirmation
    )
  end
end
