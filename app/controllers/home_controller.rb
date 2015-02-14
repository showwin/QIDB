class HomeController < ApplicationController

  def index
  end

  def search
    @results = Definition.search(params['query'])
    render :index
  end

  def output_csv
    @column_names = ['指標番号', '指標群', '名称', '分母', '分子', 'リスク調整',
       '薬剤一覧出力', 'グラフの並び順', '指標タイプ']
    all = Definition.all
    @contents = []
    all.each do |record|
      content = []
      content << record['指標番号']
      content << record['指標群']
      content << record['名称']
      content << (record['定義の要約'] ? record['定義の要約']['分母'] : '')
      content << (record['定義の要約'] ? record['定義の要約']['分子'] : '')
      content << record['リスクの調整因子の定義']
      content << record['薬剤一覧の出力']
      content << record['結果提示時の並び順']
      content << record['指標タイプ']
      @contents << content
    end

    respond_to do |format|
      format.csv do
        send_data render_to_string, type: :csv
      end
    end
  end

end
