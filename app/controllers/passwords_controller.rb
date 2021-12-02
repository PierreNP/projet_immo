class PasswordsController < ApplicationController
  before_action :authenticate_user!, only: [:update]
  def forgot
    if params[:email].blank?
      return render json: {error: 'Email not present'}
    end
    @user = User.find_by(email: params[:email])

    if @user.present? 
      @user.generate_password_token!
      puts "*" * 100
      puts @user
      puts @user.reset_password_token
      puts "*" * 100
      UserMailer.reset_password(@user).deliver_now
      render json: {status: 'ok'}, status: :ok
    else
      render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
    end
  end

  def reset
    token = params[:token].to_s
    
    user = User.find_by(reset_password_token: token)
    puts "*" * 100
    puts params
    puts user.reset_password_token
    puts user.email
    puts token
    puts "*" * 100
    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: {status: 'ok'}, status: :ok
      else
        render json: {error: user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
    end
  end
  def update
    # Voir si on controle le current password 
    if params[:password].blank?
      return render json: {error: 'New password not present'}
    end
    current_user.update(password: params[:password])
  end 
end 