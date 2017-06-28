class FreelancerReviewsController < ApplicationController
  # GET /freelancer_reviews/new
  def new
    @review = FreelancerReview.new
    @review.job_id = params[:job_id]
  end

  # POST /freelancer_reviews
  def create
    @review = FreelancerReview.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to ended_for_freelancer_details_jobs_url(id: @review.job_id), notice: 'Your review has been submitted successfully.' }
      else
        format.html { render :new }
      end
    end
  end

private
  def review_params
    params.require(:freelancer_review).permit(:job_id, :score, :notes)
  end
end
