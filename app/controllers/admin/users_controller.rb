class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  before_action :set_user, only: [:show, :update, :destroy]


  def index
    @all_users = User.all
  end

  def show
    puts current_user
    puts current_user.id
  end

  def new
    @user = User.new
  end

  def create
    puts params
    @user = User.create(admin_user_params)
    if @user.save
      redirect_to admin_users_path
    end
    #else, blablabla
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(admin_user_params)
    redirect_to admin_users_path
  end

  def destroy
    @user.destroy
  end 

  private

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user_params
    params.require(:user).permit(:first_name, :username, :last_name, :email, :password, :is_admin)
  end

end
