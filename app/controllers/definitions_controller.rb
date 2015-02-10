class DefinitionsController < ApplicationController
  before_action :set_definition, only: [:show, :edit, :update]

  def show
  end

  def new
  end

  def create
    @definition = Definition.new
    @definition.set_params(params)

    # すでにその指標番号が存在するなら削除する
    @definition.remove_duplicate

    # 検索用のレコード作成 と 定義の作成
    if @definition.create_search_index(params) && @definition.save
      render :success
    else
      render :new
    end
  end

  def edit
  end

  def update
    @definition = Definition.new
    @definition.set_params(params)

    # すでにその指標番号が存在するなら削除する
    @definition.remove_duplicate

    # 検索用のレコード作成 と 定義の作成
    if @definition.create_search_index(params) && @definition.save
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
