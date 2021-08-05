class UsersController < ApplicationController
  before_action :sign_in_required
  def index
    @users=User.all.order(:id).page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
  end
end
