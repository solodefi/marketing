class ProposalsController < EndUserBaseController

  before_action :set_proposal, only: [:show, :edit, :update, :destroy]

  # GET /proposals
  def index    
  end

  # GET /proposals/1
  def show
  end

  # GET /proposals/new
  def new
    @proposal = Proposal.new
    @@job_id = params[:job_id]
  end

  # GET /proposals/1/edit
  def edit
  end

  # POST /proposals
  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.user_id = current_user.id
    @proposal.job_id = @@job_id

    respond_to do |format|
      if @proposal.save
        format.html { redirect_to @proposal.job, notice: 'Your proposal has been sent successfully.' }
      else
        format.html { render :new }
      end
    end
    
  end

  # PATCH/PUT /proposals/1
  def update
    @proposal.update(proposal_params)

    respond_to do |format|
      if @proposal.save
        format.html { redirect_to @proposal, notice: 'Your proposal has been successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /proposals/1
  def destroy
  end

  private

  # User callbacks to share common setup or contraints between actions
  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def proposal_params
    params.require(:proposal).permit(:price, :description, :start_date, :end_date)
  end
end

