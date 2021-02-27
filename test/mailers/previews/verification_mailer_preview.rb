# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/varification_mailer
class VerificationMailerPreview < ActionMailer::Preview
  def verify
    VerificationMailer.with(user: User.last).verify
  end
end
