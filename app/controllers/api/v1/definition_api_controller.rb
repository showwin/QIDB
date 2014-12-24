module Api
  module V1
    class DefinitionApiController < ApiController

      def index
        # すべての定義書を返す場合
        if params[:id] == "all"
          @defs = Definition.all
        # idが指定されている場合
        elsif params[:id].present?
          @defs = Definition.where(指標番号: params[:id]).first
        end
        if @defs.nil?
          render_not_found
        else
          render :json => @defs
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
