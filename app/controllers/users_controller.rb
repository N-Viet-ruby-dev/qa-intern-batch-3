class UsersController < ApplicationController
  before_action :load_user, only: %i(show edit update)
  before_action :logged_in_user, only: %i(index edit update)
  before_action :correct_user, only: %i(update edit)

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
  end

  def create
    @user = User.new user_params
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      redirect_to root_path, warning: "Please check your email to activate your account."
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes user_params
        format.js { flash[:success]= t "messages.success.user.update" }
      else
        format.js { flash[:danger]= t "messages.failed.user.update"}
      end
    end
  end

  private

  def user_params
    params.require(:user).permit :email, :full_name, :user_name, :role,
    :password, :password_confirmation, :avatar
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to root_path, danger: "not found"
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_path) unless current_user?(@user)
  end
end
