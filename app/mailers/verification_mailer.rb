# frozen_string_literal: true

class VerificationMailer < ApplicationMailer
  def verify
    @user = params[:user]
    mail(to: @user.email, subject: "Finish setting up your Hypercable account: verify your email address")
  end
end
