class ProposalsController < EndUserBaseController

  private

    def proposal_params
      params.require(:proposal).permit(:job_id, :price, :description, :start_date, :end_date, :user_id)
    end
end

