# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base

  before_action :basic_authentication if Rails.env.production?

  private

  def basic_authentication
    authenticate_or_request_with_http_basic do |user, password|
      user == [qidb] && password == [qidbedit]
    end
  end

end
