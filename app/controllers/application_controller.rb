class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def authenticate
    redirect_to root_path unless admin?
  end

  private

  def admin?
    session[:admin]
  end
  helper_method :admin?

  def format_query_keywords(query)
    query.present? ? query.gsub(/(　)+/, "\s").split("\s") : []
  end
end
