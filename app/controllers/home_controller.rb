class HomeController < ApplicationController
  def index
    Rails.logger.debug "Rendering Layout: application"
    render layout: "application", html: ""
  end
end