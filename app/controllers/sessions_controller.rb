class SessionsController < ApplicationController
  before_action :load_email_user, only: :create

  def new; end

  def create
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        remember? @user
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        redirect_to root_path, warning: message
      end
    else
      respond_to do |format|
        format.js { flash.now[:danger] = "Invalid email/password combination" }
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def remember? user
    log_in user
    if params[:session][:remember_me] == Settings.session.remember_me
      remember user
    else
      forget user
    end
    user.update_attribute :log_out_at, nil
    redirect_back_or user
  end

  def load_email_user
    @user = User.find_by email: params[:session][:email].downcase
  end
end
