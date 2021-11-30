class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @all_users = User.all
    render json: {users: @all_users}
  end

  def show
    render json: {user: @user}
  end

  def create
    byebug
    @user = User.create(admin_user_params)
    if @user.save
      render json: {message: "User successfully created"}
    else
      render json: {message: "User unsuccessfully created"}
    end
  end

  def update
    if @user.update(admin_user_params)
      render json: {message: "User successfully updated"}
    else
      render json: {message: "Update error"}
    end
  end

  def destroy
    if @user.destroy
      render json: {message: "User successfully deleted (you are admin, you do what you want)"}
    else
      render json: {message: "User NOT successfully deleted (you are admin, you do what you want but it still didn't work)"}
    end
  end 

  private

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user_params
    params.require(:user).permit(:first_name, :username, :last_name, :email, :password, :is_admin)
  end

end
