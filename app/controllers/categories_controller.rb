class CategoriesController < EndUserBaseController

  def index
  	@categories = Category.all
  end

  private

    def category_params
      params.require(:category).permit(:title, :description)
    end
end