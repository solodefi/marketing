class ProfessionsController < ApplicationController

  def change_categories
      @categories = Profession.find_by_id(params[:profession_id]).try(:categories)
      if @categories.present?
        render :html=>view_context.options_from_collection_for_select(@categories, :id, :title)
      else
        render :html=>""
      end
    end

  private

    def profession_params
      params.require(:profession).permit(:title)
    end
end

