module JobsHelper
  
  def is_applied(job)
    is_applied = false
    job.proposals.each do |proposal|
      if proposal.user_id == current_user.id
        is_applied = true
      end
    end

    return is_applied

  end
end
