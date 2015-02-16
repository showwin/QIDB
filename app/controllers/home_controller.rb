class HomeController < ApplicationController

  def index
  end

  def search
    keywords = get_search_query
    @results = Definition.search(keywords)
    render :index
  end

  def output_csv
    @column_names = ['qip', 'jha', 'jmha', 'sai', 'min', 'jma', 'ajha', 'nho', 'rofuku', 'jamcf',
       '指標群', '名称', '分母', '分子', '薬剤一覧出力', 'グラフの並び順', '指標タイプ']
    all = Definition.where(soft_delete: false)
    @contents = []
    all.each do |record|
      content = []
      content << record['numbers']['qip']
      content << record['numbers']['jha']
      content << record['numbers']['jmha']
      content << record['numbers']['sai']
      content << record['numbers']['min']
      content << record['numbers']['jma']
      content << record['numbers']['ajha']
      content << record['numbers']['nho']
      content << record['numbers']['rofuku']
      content << record['numbers']['jamcf']
      content << record['group']
      content << record['name']
      content << (record['def_summary'] ? record['def_summary']['denom'] : '')
      content << (record['def_summary'] ? record['def_summary']['numer'] : '')
      content << record['drug_output']
      content << record['order']
      content << record['indicator']
      @contents << content
    end

    respond_to do |format|
      format.csv do
        send_data render_to_string, type: :csv
      end
    end
  end

  private
    def get_search_query
      search_keyword = params['query']
      keyword = search_keyword.gsub(/(　)+/,"\s")
      keyword.split("\s")
    end

end
