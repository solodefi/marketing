class JobOfferMailer < ApplicationMailer

  def hire_job_message(job)
    @job = job

    mail to:@job.freelancer.email, subject: "Structured Thinking Notification"
  end

  def end_job_message(job)
    @job = job

    mail to:@job.freelancer.email, subject: "Structured Thinking Notification"
  end
end
