class Job < ApplicationRecord
	
	belongs_to :user, validate: true
	has_many :proposals, dependent: :destroy
	belongs_to :profession

	belongs_to :freelancer, :class_name => "User", :foreign_key => :freelancer_id

	has_one :freelancer_review, dependent: :destroy
	has_one :client_review, dependent: :destroy

	serialize :category_ids, Array

	enum status: [ :open, :progress, :end]

	validates_numericality_of :price, greater_than_or_equal_to: 0, only_integer: true
	validates :title, presence: true, allow_blank: false
	validates :description, presence: true, allow_blank: false
	validates :postcode, presence: true, allow_blank: false

	scope :title, -> (title) { where("lower(title) like ?", "%#{title.downcase}%") }
	scope :category, -> (category_id) { where("category_ids like ?", "%#{category_id}%") }

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

	def time_duration_spent
		str_to_show = ""
		if self.started_at.present? && self.ended_at.present?
			str_to_show = self.started_at.to_date.to_s + " to " + self.ended_at.to_date.to_s
		elsif self.started_at.present? && !self.ended_at.present?
			str_to_show = "start at " + self.started_at.to_date.to_s
		elsif !self.started_at.present? && self.ended_at.present?
			str_to_show = "end by " + self.ended_at.to_date.to_s
		else
			str_to_show = "N/A"
		end
		str_to_show
	end

	def str_categories
		categories.join(', ')
	end

end
