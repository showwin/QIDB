class HomeController < ApplicationController

  def index
  end

  def search
    keywords = get_search_query
    @results = Definition.search(keywords)
    render :index
  end

  def output_csv
    @column_names = ['qip', '年度', '指標群', '名称', '意義', '分母', '分子', '薬剤一覧出力', 'グラフの並び順']
    all = Definition.where(soft_delete: false)
    @contents = []

    all.each do |record|
      content = []
      content << record.numbers['qip']
      #content << record.numbers['jha']
      #content << record.numbers['jmha']
      #content << record.numbers['sai']
      #content << record.numbers['min']
      #content << record.numbers['jma']
      #content << record.numbers['ajha']
      #content << record.numbers['nho']
      #content << record.numbers['rofuku']
      #content << record.numbers['jamcf']
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

    bom_set
    respond_to do |format|
      format.csv do
        send_data  bom + render_to_string, type: :csv
      end

    end
  end

  private
    def get_search_query
      search_keyword = params['query']
      keyword = search_keyword.gsub(/(　)+/,"\s")
      keyword.split("\s")
    end

    def bom_set
        bom = "   "
        bom.setbyte(0, 0xEF)
        bom.setbyte(1, 0xBB)
        bom.setbyte(2, 0xBF)
    end

end
