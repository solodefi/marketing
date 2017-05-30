class JobsController < EndUserBaseController

  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
	def index
		@jobs = current_user.jobs
	end

  # GET /jobs/1
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  def create
    @job = Job.new(job_params)
    @job.user_id = current_user.id

    @job.save

    redirect_to @job, notice: 'Job has been successfully created.'
  end

  # PATCH/PUT /jobs/1
  def update
    @job.update(job_params)

    redirect_to @job, notice: 'Job has been successfully updated.'
  end

  # DELETE /jobs/1
  def destroy
  end

  private

  # User callbacks to share common setup or contraints between actions
  def set_job
    @job = Job.find(params[:id])
  end

  # Strong params
  def job_params
    params.require(:job).permit(:title, :price, :description, :postcode, :start_date, :end_date, :user_id, :category_ids => [])
  end

end