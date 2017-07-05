module RedirectLanding

  def path_to_redirect 
    if current_user.email_confirmed
      if current_user.user_type == "Client"
        return jobs_url
      elsif current_user.user_type == "Freelancer"
        return browse_jobs_url
      end
    else
      verification_email_url
    end
    
  end

  def path_to_redirectparam1(user)
    if user.email_confirmed
      if user.user_type == "Client"
          return jobs_url
      elsif user.user_type == "Freelancer"
          return browse_jobs_url
      end
    else
      verification_email_url
    end
  end

end