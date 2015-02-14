module Api
  module V1
    class DefinitionApiController < ApiController

      def index
        # すべての定義書を返す場合
        if params[:project].blank? && params[:id] == "all"
          @defs = Definition.where(soft_delete: false)
        # 特定の機関の全ての定義書を返す場合
        elsif params[:project].present? && params[:id] == "all"
          @defs = Definition.where(soft_delete: false)
                            .ne("numbers.#{params[:project]}" => nil)
        # 機関と指標番号が指定されている場合
        elsif params[:project].present? && params[:id].present?
          @defs = Definition.where(soft_delete: false)
                            .where("numbers.#{params[:project]}" => params[:id])
        end
        if @defs.nil?
          render_not_found
        else
          render 'index.json.jbuilder'
        end
      end

      private

      def render_not_found
        status, msg = 404, 'not found'
        render json: { status: status, message: msg }
      end

    end
  end
end
