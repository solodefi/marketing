module RedirectLanding

  def path_to_redirect 
    if current_user.user_type == "Client"
        return jobs_url
    elsif current_user.user_type == "Freelancer"
        return browse_jobs_url
    end
  end

end