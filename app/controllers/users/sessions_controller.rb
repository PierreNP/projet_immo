class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    @user = User.find_by(email:resource.email)
    if(@user && @user.encrypted_password == resource.encrypted_password)
      render json: { user:@user, message: 'You are logged in.' }, status: :ok
    elsif(@user)
      render json: {user:resource, message: 'Incorrect Password' }, status: :unauthorized
    else
      render json: {user:resource, message: 'Incorrect Email' }, status: :unauthorized
    end 
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: "You are logged out." }, status: :ok
  end

  def log_out_failure
    render json: { message: "Hmm nothing happened."}, status: :unauthorized
  end
end