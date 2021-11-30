class ApplicationController < ActionController::API
  def is_admin?
    if current_user.is_admin == false
      redirect_to user_path(current_user.id)
    end
    # foutre un flash
  end
end
