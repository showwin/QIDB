class DefinitionsController < ApplicationController
  before_action :set_definition, only: [:show, :edit, :update, :destroy]

  # GET /definitions
  # GET /definitions.json
  def index
    @definitions = Definition.all
  end

  # GET /definitions/1
  # GET /definitions/1.json
  def show
  end

  # GET /definitions/new
  def new
  end

  # GET /definitions/1/edit
  def edit
  end

  # POST /definitions
  # POST /definitions.json
  def create
    @definition = Definition.new
    @definition.set_params(params)

    #すでにその指標番号が存在するなら削除する
    @definition.remove_duplicate

    if @definition.save
      redirect_to @definition
    else
      render :new
    end
  end

  # PATCH/PUT /definitions/1
  # PATCH/PUT /definitions/1.json
  def update
    respond_to do |format|
      if @definition.update(definition_params)
        format.html { redirect_to @definition, notice: 'Definition was successfully updated.' }
        format.json { render :show, status: :ok, location: @definition }
      else
        format.html { render :edit }
        format.json { render json: @definition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /definitions/1
  # DELETE /definitions/1.json
  def destroy
    @definition.destroy
    respond_to do |format|
      format.html { redirect_to definitions_url, notice: 'Definition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_definition
      @definition = Definition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def definition_params
      params[:definition]
    end
end
