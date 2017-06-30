class JobsController < EndUserBaseController

  before_action :set_job, only: [:show, :edit, :update, :destroy, :browse_job_details, :in_progress_details, :ended_details, :hire_freelancer, :end_contract, :in_progress_by_freelancer_details, :ended_for_freelancer_details]

  before_action :authenticate_user!, except: [:job_search]

  # GET /jobs
	def index
    if current_user.user_type == 'Client'
      @jobs = current_user.jobs.where(:status => 'open').order("created_at DESC")
    else
      @jobs = Array.new
      current_user.proposals.each do |p|
        if p.job.status == 'open'
          @jobs.append(p.job)
        end
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

  def job_search

    @alljobs = Job.where(:status => 'open').order("created_at DESC")
    @jobs = []
    count = 0
    @searchText = params[:searchText]
    @searchText = @searchText.downcase()

    @alljobs.each do |job|
      if job.title.downcase().include?@searchText #job.title.find( params[ :searchText ])
        @jobs[count] = job
        count += 1
      elsif job.description.downcase().include?@searchText
        @jobs[count] = job
        count += 1  
      elsif job.str_categories.downcase().include?@searchText
        @jobs[count] = job
        count += 1 
      elsif job.postcode.downcase().include?@searchText
        @jobs[count] = job
        count += 1 
      end
    end

  end

  # For Client
  def in_progress
    @jobs = current_user.jobs.where(:status => 'progress').order("started_at DESC")
  end

  def in_progress_details
  end

  def ended
    @jobs = current_user.jobs.where(:status => 'end').order("ended_at DESC")
  end

  def ended_details
  end

  def leave_client_feedback
  end

  def hire_freelancer
    @job.status = 'progress'
    @job.started_at = Time.now
    @job.freelancer_id = params[:freelancer_id]

    respond_to do |format|
      if @job.save
        JobOfferMailer.hire_job_message(@job).deliver
        format.html { redirect_to in_progress_jobs_url, notice: 'Job has been successfully offered.' }
      else
        format.html { redirect_to jobs_url, notice: 'Failed to hire the freelancer. Please try again later.' }
      end
    end
  end

  def end_contract
    @job.status = 'end'
    @job.ended_at = Time.now

    respond_to do |format|
      if @job.save
        JobOfferMailer.end_job_message(@job).deliver
        format.html { redirect_to new_client_review_url(:job_id => @job.id), notice: 'Job has been successfully ended.' }
      else
        format.html { redirect_to in_progress_jobs_url, notice: 'Failed to end the job. Please try again later.' }
      end
    end

  end

  # For Freelancer
  def browse
    @jobs = Job.where(:status => 'open').order("created_at DESC")
  end

  def browse_job_details
  end

  def in_progress_by_freelancer
    @jobs = Array.new
    current_user.proposals.each do |p|
      if p.job.status == 'progress'
        @jobs.append(p.job)
      end
    end
    @jobs.sort! { |a,b| b.started_at <=> a.started_at}
  end

  def in_progress_by_freelancer_details
  end

  def ended_for_freelancer
    @jobs = Array.new
    current_user.proposals.each do |p|
      if p.job.status == 'end'
        @jobs.append(p.job)
      end
    end
    @jobs.sort! { |a,b| b.ended_at <=> a.ended_at}
  end

  def ended_for_freelancer_details
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

  def hire_freelancer_params
    params.permit(:job_id, :freelancer_id)
  end

end