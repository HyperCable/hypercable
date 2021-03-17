# frozen_string_literal: true

class SessionsController < ApplicationController
  layout "auth"
  skip_before_action :authenticate_user!, only: %i[new create]
  skip_before_action :email_verify!, only: %i[new create]

  def new
  end

  def create
    @user = User.where(email: user_params[:email]).first
    if @user&.authenticate(user_params[:password])
      set_current_user(@user, true)

      if @user.email_verified?
        flash[:success] = "Login successfully"
        if @user.sites.count == 0
          redirect_to new_site_path
        elsif @user.sites.count == 1
          redirect_to site_path(@user.sites.first)
        else
          redirect_to sites_path
        end
      else
        redirect_to verification_registrations_path, error: "Please verify your email"
      end
    else
      flash.now[:error] = "Email or password is wrong"
      render "new"
    end
  end

  def destroy
    cookies[:remember_token] = {
      value: nil
    }
    redirect_to root_path
 end

  def user_params
    params.require(:user).permit(:email, :password, :remember_me)
  end
end
