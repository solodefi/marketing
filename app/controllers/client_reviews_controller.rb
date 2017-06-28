class ClientReviewsController < EndUserBaseController

  # GET /client_reviews/new
  def new
    @review = ClientReview.new
    @review.job_id = params[:job_id]
  end

  # POST /client_reviews
  def create
    @review = ClientReview.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to ended_details_jobs_url(id: @review.job_id), notice: 'Your review has been submitted successfully.' }
      else
        format.html { render :new }
      end
    end
  end

private
  def review_params
    params.require(:client_review).permit(:job_id, :score, :notes)
  end

end
