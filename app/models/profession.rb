class Profession < ApplicationRecord

  has_many :categories, dependent: :destroy

  validates :title, presence: true, allow_blank: false
  
  def to_s
    self.title
  end

end
