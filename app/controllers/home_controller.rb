class HomeController < ApplicationController

  def index
  end

  def login
    session[:admin] = true
    redirect_to root_path
  end

  def logout
    session[:admin] = nil
    redirect_to root_path
  end

  def search
    session[:user_id] = 3
    keywords = format_query_keywords(params[:query])
    @results = Definition.search(keywords)
    render :index
  end

  def output_csv
    all = Definition.active
    @contents = []

    all.each do |record|
      content = []
      content << record.numbers['qip']
      content << record.years
      content << record.group
      content << record.name
      content << record.meaning
      content << (record.def_summary ? record.def_summary['denom'] : '')
      content << (record.def_summary ? record.def_summary['numer'] : '')
      content << record.drug_output
      content << record.order
      @contents << content
    end

    respond_to do |format|
      format.csv do
        send_data render_to_string, type: :csv
      end
    end
  end
end
