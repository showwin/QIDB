class HomeController < ApplicationController

  def index
  end

  def search
    @results = StringData.search(params['query']).to_a
    render :index
  end
end
