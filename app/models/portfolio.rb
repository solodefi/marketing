class Portfolio < ApplicationRecord

  belongs_to :user, validate: true
  belongs_to :profession

  serialize :category_ids, Array

  validates :overview, presence: true, allow_blank: false
  
  mount_uploader :image, PortfolioUploader

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :rotation_angle, :zoom_w, :zoom_h, :zoom_x, :zoom_y, :drag_x, :drag_y, :image_backup

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
