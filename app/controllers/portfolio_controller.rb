class PortfolioController <  EndUserBaseController
  respond_to :js
  skip_before_filter :verify_authenticity_token 

  def on_portfolio_edit
    puts "**************************on_portfolio_edit**************************************"
  end
  def on_portfolio_add
    @user = current_user
    puts "**************************on_portfolio_add**************************************"
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.user_id = current_user.id
    @portfolio.save
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  # def show
  # end

  def new
    @portfolio = Portfolio.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end
  
  def portfolio_params
    params.require(:portfolio).permit(:title, :overview, :image,:completion_date, :profession_id, :category_ids => [])
  end
end
