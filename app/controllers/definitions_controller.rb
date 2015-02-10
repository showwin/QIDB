class DefinitionsController < ApplicationController
  before_action :set_definition, only: [:show]

  def show
    @logs = ChangeLog.where(指標番号: params[:id]).to_a
  end

  def new
  end

  def create
    @definition = Definition.new
    @definition.set_params(params)

    @log = ChangeLog.new
    @log.set_params(params)

    # すでにその指標番号が存在するなら削除する
    @definition.remove_duplicate

    # 検索用のレコード作成 と 定義の作成
    if @definition.create_search_index(params) && @definition.save && !@log['変更者'].blank? && !@log['変更メッセージ'].blank? && @log.save
      render :success
    else
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
      @definition = Definition.where(指標番号: params[:id]).first
    end
end
