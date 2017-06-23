class Proposal < ApplicationRecord
	belongs_to :job, validate: true
	belongs_to :user, validate: true

	validates_numericality_of :price, greater_than_or_equal_to: 0, only_integer: true

  validates :description, presence: true, allow_blank: false

  def time_duration
    str_to_show = ""
    if self.start_date.present? && self.end_date.present?
      str_to_show = self.start_date.to_s + " to " + self.end_date.to_s
    elsif self.start_date.present? && !self.end_date.present?
      str_to_show = "start at " + self.start_date.to_s
    elsif !self.start_date.present? && self.end_date.present?
      str_to_show = "end by " + self.end_date.to_s
    else
      str_to_show = "N/A"
    end
    str_to_show
  end
	
end
