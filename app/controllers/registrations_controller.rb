# frozen_string_literal: true

class RegistrationsController < ApplicationController
  layout "auth"
  skip_before_action :authenticate_user!, only: %i[new create verify]
  skip_before_action :email_verify!, only: %i[new create verify verification]

  def new
    @user = User.new
  end

  def verify
    if user = User.where(email_verification_token: params[:token]).first
      user.update(email_verified: true)
      flash[:success] = "Email verify successed"
    else
      flash[:error] = "Email verify failed"
    end
    redirect_to new_session_path
  end

  def verification
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies[:remember_token] = {
        value: @user.remember_token,
        expires: 1.year.from_now.utc
      }
      redirect_to verification_registrations_path
    else
      flash[:error] = t("sign_up_failed")
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
