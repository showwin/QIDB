class DefinitionsController < ApplicationController
  before_action :set_definition, only: [:show, :show_en, :edit, :duplicate, :update, :pdf]
  before_action :set_log, only: [:show, :show_en, :edit, :duplicate, :pdf]
  before_action :authenticate,
                except: [:show, :show_en, :show_table, :show_table_en, :search,
                         :pdf, :select, :pdfs, :search_pdf, :search_en, :output_csv_data]

  def show
  end

  def show_en
  end

  def show_table
    @definitions = Definition.active.sort_by { |e| e['index'] }
  end

  def show_table_en
    @definitions = Definition.active.sort_by { |e| e['index'] }
  end

  def new
  end

  def create
    @definition = Definition.init_params(DefinitionForm.new(params))

    # 指標番号や変更者などの必須要素の確認とエラーメッセージ作成
    @error = check_necessary_params

    # すでに使われている指標番号を見つける
    @dups = @definition.find_duplicates

    return if @error.present?
    if @dups.blank?
      @definition.save_with_log!(params[:editor], params[:message])
    else
      @definition.save_draft_with_log!(params[:editor], params[:message])
    end
  end

  def confirm
    definition = Definition.find(params[:id])
    definition.make_public
    redirect_to :def_success
  end

  def success
  end

  def edit
  end

  def duplicate
    @definition.numbers = {}
    @logs = []
    @duplicate_flg = true
    render :edit
  end

  def destroy
    @definition = Definition.find(params[:id])
    @definition.remove_duplicate
    redirect_to root_path
  end

  def upload
  end

  def import
    if Definition.read_csv(params[:csv_file])
      render :success
    else
      render :upload
    end
  end

  def search
    @definition = Definition.active.find_by("numbers.#{params[:prjt]}" => params[:qid])
    redirect_to action: 'show', id: @definition._id
  end

  def search_pdf
    @definition = Definition.active.find_by("numbers.#{params[:prjt]}" => params[:qid])
    redirect_to action: 'pdf', id: @definition._id, format: :pdf
  end

  def search_en
    @definition = Definition.active.find_by("numbers.#{params[:prjt]}" => params[:qid])
    redirect_to action: 'show_en', id: @definition._id
  end

  def output_csv_data
    @contents = []
    definition = Definition.active.find(params[:id])
    data = case params[:type]
    when 'def_numer', 'def_denom' then definition.definitions[params[:type]][params[:key]]['data']
    when 'def_risks', 'annotation', 'standard_value', 'references' then definition[params[:type]][params[:key]]['data'] end
    if data.present?
      header, content = [], []
      data.each do |col|
        col.each do |key,value|
          header << key
          content << value
        end
      end
    end
    @contents << header
    content.transpose.each do |i|
      @contents << i
    end
    render 'home/output_csv.csv'
  end

  def pdf
    respond_to do |format|
      format.html { redirect_to def_pdf_path(id: params[:id], format: :pdf) }
      format.pdf do
        render pdf: 'sheet',
               encoding: 'UTF-8',
               template: '/definitions/show.pdf.erb',
               layout: 'pdf.html.erb',
               no_background: false
      end
    end
  end

  def select
    @project = params[:project]
    @year = params[:year]
    @keywords = format_query_keywords(params[:keywords])
    unindexed, indexed = Definition.active
              .find_by_project(@project)
              .find_by_year(@year)
              .search(@keywords)
              .sort_by { |e| e['index'] }
              .partition{|e| e['index'] == "" }
    @definitions = indexed + unindexed
  end

  def pdfs
    ids = []
    params.keys.each do |key|
      ids << key if key.length == 24
    end
    unindexed, indexed = Definition.active.in('_id': ids).sort_by { |e| e['index'] }.partition{|e| e['index'] == "" }
    #@definitions = Definition.active.in('_id': ids).sort_by { |e| e['index'] }.to_a
    @definitions = indexed + unindexed
    respond_to do |format|
      format.pdf do
        render pdf: 'sheet',
               encoding: 'UTF-8',
               template: '/definitions/selected.pdf.erb',
               layout: 'pdf.html.erb',
               no_background: false
      end
    end
  end

  private

  def set_definition
    @definition = Definition.find(params[:id])
  end

  def set_log
    @logs = ChangeLog
            .where(soft_delete: false)
            .where(log_id: @definition.log_id)
            .order('_id desc').to_a
  end

  def check_necessary_params
    error = []
    error << '指標番号を記入して下さい' if @definition.numbers.blank?
    error << '変更者を記入して下さい' if params[:editor].blank?
    error << '変更メッセージを記入して下さい' if params[:message].blank?
    error
  end
end
