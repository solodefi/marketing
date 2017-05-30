class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :jobs, dependent: :destroy
  has_many :proposals, dependent: :destroy

  belongs_to :location

  enum user_type: [ :Client, :Freelancer ]

  mount_uploader :image, ImageUploader

  def country_name
  	c = ISO3166::Country[country]
  	c.translations[I18n.locale.to_s] || c.name
  end

  def full_name
    full_name = self.first_name + " " + self.last_name
  end

  def to_s
    full_name
  end
end
