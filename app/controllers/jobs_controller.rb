class JobsController < EndUserBaseController


	def index
		@jobs = current_user.jobs
	end

  private

  def job_params
    params.require(:job).permit(:title, :price, :description, :start_date, :end_date, :posted_by, :category_ids => [])
  end

end