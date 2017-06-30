class Deposit < ApplicationRecord
  belongs_to :user

  validates_numericality_of :amount, greater_than_or_equal_to: 1
end
