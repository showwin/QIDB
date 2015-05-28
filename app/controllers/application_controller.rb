class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session

  before_filter :basic

  private
  def basic
    authenticate_or_request_with_http_basic do |user, pass|
      user == 'med-econ' && pass == 'med-econ'
    end
  end
end
