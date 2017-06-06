class Job < ApplicationRecord
	belongs_to :user, validate: true
	has_many :proposals, dependent: :destroy
	belongs_to :profession

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

	def str_categories
		categories.join(', ')
	end

end
