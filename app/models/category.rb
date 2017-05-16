class Category < ApplicationRecord

	validates :title, presence: true, allow_blank: false
	
	def to_s
  	self.title
  end
end
