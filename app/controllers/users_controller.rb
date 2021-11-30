class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :destroy]
  respond_to :json

  def index 
    @users = User.all
    render json: @users
  end

  def create
    @user = User.create(user_params)
  end


  def show
    if @user.avatar.attached?
      avatar = rails_blob_path(@user.avatar)
      render json: {user: @user, avatar: avatar}
    else 
      render json: {user: @user}
    end
  end

  def update
    if params[:avatar]
      @user.update(avatar: params[:avatar])
      avatar = rails_blob_path(@user.avatar)
      render json: {user: @user, avatar: avatar}
    elsif @user.update(user_params)
      if @user.avatar.attached?
        avatar = rails_blob_path(@user.avatar)
        render json: {user: @user, avatar: avatar}
      elsif @user.update(user_params)
        if @user.avatar.attached?
          avatar = rails_blob_path(@user.avatar)
          render json: {user: @user, avatar: avatar}
        else 
          render json: {user: @user}
        end
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: {message: "As a normal user (not admin), you are not allowed to update other users than yourself"}
    end
  end

  def destroy

    if @user.destroy
      render json: {message: "User has been successfully deleted ! "}
    else 
      render json: {message: "You are not authorized to delete this user"}
    end 
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :email, :first_name, :last_name, :avatar, :is_landlord, :is_admin)
  end

end
