class DefinitionsController < ApplicationController
  before_action :set_definition, only: [:show, :edit, :update]
  before_action :set_form_params, only: [:show, :new, :edit]

  def show
    @logs = ChangeLog.where(_id: params[:id]).to_a
  end

  def new
  end

  def create
    @definition = Definition.new
    @definition.set_params(params)

    @log = ChangeLog.new
    @log.set_params(params, @definition._id.to_s)

    # すでにその指標番号が存在するなら論理削除する
    @definition.remove_duplicate

    # 指標番号や変更者などの必須要素の確認とエラーメッセージ作成
    @error = {}
    confirm

    # 検索用のレコード作成 と 定義の作成
    if @error.blank? && (@definition.create_search_index(params) && @definition.save)
      render :success
    else
      set_form_params
      render :new
    end
  end

  def edit
    @edit_logs = ChangeLog.where(_id: params[:id]).to_a
  end

  def update
    @definition = Definition.new
    @definition.set_params(params)

    # すでにその指標番号が存在するなら削除する
    @definition.remove_duplicate

    # 検索用のレコード作成 と 定義の作成
    if @definition.create_search_index(params) && @definition.save && @log.save
      render :success
    else
      set_form_params
      render :new
    end
  end

  def upload
  end

  def import
    if Definition.read_csv(params[:csv_file])
      render :success
    else
      render :new
    end
  end

  private
    def set_definition
      @definition = Definition.where(_id: params[:id]).first
    end

    def set_form_params
      @projects = [['QIP', 'qip'], ['日病', 'jha'], ['全自病協', 'jmha'], ['済生会', 'sai'], ['全日本民医連', 'min'],
                   ['日本医師会', 'jma'], ['全日病', 'ajha'], ['国病', 'nho'], ['労災', 'rofuku'], ['慢医協', 'jamcf']]
      @years = ['2008', '2010', '2012', '2014']
      @dataset = ['DPC様式1', 'Fファイル', 'EFファイル', 'Dファイル']
    end

    def confirm
      #if @definition['指標番号'].blank?
      #  @messages['指標番号'] = '指標番号を記入して下さい'
      #end
      if @log['editor'].blank?
        @error['editor'] = '変更者を記入して下さい'
      end
      if @log['message'].blank?
        @error['message'] = '変更メッセージを記入して下さい'
      end
    end

end
