class JobsController < EndUserBaseController

  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
	def index
    if current_user.user_type == 'Client'
      @jobs = current_user.jobs.order("created_at DESC")
    else
      @jobs = Array.new
      current_user.proposals.each do |p|
        @jobs.append(p.job)
      end
      @jobs.sort! { |a,b| b.created_at <=> a.created_at}
    end
		
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

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job has been successfully created.' }
      else
        format.html { render :new }
      end
    end

  end

  # PATCH/PUT /jobs/1
  def update
    @job.update(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job has been successfully updated.' }
      else
        format.html { render :edit }
      end
    end
    
  end

  # DELETE /jobs/1
  def destroy
  end

  def browse
    @jobs = Job.all.order("created_at DESC")
  end

  private

  # User callbacks to share common setup or contraints between actions
  def set_job
    @job = Job.find(params[:id])
  end

  # Strong params
  def job_params
    params.require(:job).permit(:title, :price, :description, :postcode, :start_date, :end_date, :user_id, :profession_id, :category_ids => [])
  end

end