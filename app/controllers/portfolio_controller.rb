class PortfolioController <  EndUserBaseController
  respond_to :js
  skip_before_filter :verify_authenticity_token 

  before_action :set_portfolio, only: [:edit, :update, :destroy]

  def new
    puts "**************************portfolio_new**************************************"
    @portfolio = Portfolio.new
  end

  def create
    @user = current_user
    puts "**************************on_portfolio_create**************************************"
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.user_id = current_user.id
    @portfolio.save
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def edit
    puts "**************************portfolio_edit*************************************"
  end

  def update
    @user = current_user
    puts "**************************portfolio_update*************************************"
    @portfolio.update(portfolio_params)
    @portfolio.save
    puts "updated successfully"

    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def destroy
    @user = current_user
    puts "**************************portfolio_destroy*************************************"
    @portfolio.destroy
  end

  def show
    @user = current_user
    puts "**************************portfolio_show*************************************"
  end
  
private
  # User callbacks to share common setup or contraints between actions
  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end
  def portfolio_params
    params.require(:portfolio).permit(:title, :overview, :image,:completion_date, :profession_id, :zoom_w, :zoom_h, :zoom_x, :zoom_y, :drag_x, :drag_y, :rotation_angle, :crop_x, :crop_y, :crop_w, :crop_h, :zoom_w, :zoom_h, :zoom_x, :zoom_y, :drag_x, :drag_y, :rotation_angle, :crop_x, :crop_y, :crop_w, :crop_h, :category_ids => [])
  end
end
