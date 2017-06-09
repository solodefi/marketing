class FreelancerReview < ApplicationRecord
  belongs_to :job

  validates_numericality_of :score, greater_than_or_equal_to: 0, less_than_or_equal_to: 5, only_float: true
end
