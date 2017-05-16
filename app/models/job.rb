class Job < ApplicationRecord
	belongs_to :user, validate: true
	has_many :proposals, dependent: :destroy

	serialize :category_ids, Array

	validates_numericality_of :price, greater_than_or_equal_to: 0, only_integer: true
	validates :title, presence: true, allow_blank: false

	def categories

		ary = Array.new

		self.category_ids.each do |category_id|
			category = Category.find_by(:id => category_id)
			ary.push(category) if category.present?
		end

		return ary
	end

	def str_categories
		categories.join(', ')
	end

end
