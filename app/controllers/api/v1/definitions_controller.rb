module Api
  module V1
    # DefinitionsController
    class DefinitionsController < ApiController
      before_action :check_params

      def index
        @defs = Definition.active.search_by_prjt_and_id(params)
        if @defs.blank?
          render_404
        else
          render
        end
      end

      private

      def check_params
        render_400 if params[:project].blank? && params[:id].present?
      end

      def render_400
        render json: { status: 400, message: 'Invalid Parameters' }
      end

      def render_404
        render json: { status: 404, message: 'Not Found' }
      end
    end
  end
end
