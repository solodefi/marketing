module JobsHelper
  
  def is_applied(job)
    is_applied = false
    if current_user.present?
      job.proposals.each do |proposal|
        if proposal.user_id == current_user.id
          is_applied = true
        end
      end
    end
    

    return is_applied

  end
end
