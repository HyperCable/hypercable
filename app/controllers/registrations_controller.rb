# frozen_string_literal: true

class RegistrationsController < ApplicationController
  layout "auth"

  def new
    headers["X-Robots-Tag"] = "none"
  end
end
