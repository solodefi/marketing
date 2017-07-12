class Portfolio < ApplicationRecord

  belongs_to :user, validate: true
  belongs_to :profession

  serialize :category_ids, Array

  validates :overview, presence: true, allow_blank: false
  
  mount_uploader :image, PortfolioUploader

end
