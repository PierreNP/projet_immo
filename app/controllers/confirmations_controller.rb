class ConfirmationsController < ApplicationController
  before_action :authenticate_user!, only: [:update]
  def create
  end 
  def update
  end 
end 