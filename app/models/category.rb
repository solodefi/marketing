class Category < ApplicationRecord

  belongs_to :profession, validate: true

	validates :title, presence: true, allow_blank: false
  validates :profession_id, presence: true, allow_blank: false
	
	def to_s
  	self.title
  end
end
