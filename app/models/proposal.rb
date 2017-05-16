class Proposal < ApplicationRecord
	belongs_to :job, validate: true
	belongs_to :user, validate: true

	validates_numericality_of :price, greater_than_or_equal_to: 0, only_integer: true

	
end
