class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]
  respond_to :json

  def index 
    @users = User.all
    render json: @users
  end

  def create
    puts "💋"*20
    puts "je suis dans create"
    byebug
    puts params
    puts "💋"*20
    @user = User.create(user_params)
  end


  def show
    if @user.avatar.attached?
      avatar = rails_blob_path(@user.avatar)
      render json: {user: @user, avatar: avatar}
    else 
      render json: {user: @user}
    end
    # @avatar = rails_blob_path(@user.avatar)
    # render json: {user:@user, avatar:@avatar}
  end

  def update
    # byebug
    if current_user == @user
      if params[:avatar]
        @user.update(avatar: params[:avatar])
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
    # if @user.update(user_params)
    #   render json: {user:@user}
    # end
  end

  def destroy
    if current_user == @user
      @user.destroy
      render json: {message: "User (not admin) successfully deleted"}
    else
      render json: {message: "As a normal user (not admin), you are not allowed to delete other users than yourself"}
    end
  end

  # def avatar
  #   user = User.find_by(id: params[:id])

  #   if user&.avatar&.attached?
  #     redirect_to rails_blob_url(user.avatar)
  #   else
  #     head :not_found
  #   end
  # end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :email, :first_name, :last_name, :avatar, :is_landlord, :is_admin)
  end

end
