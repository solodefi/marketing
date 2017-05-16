class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :jobs, dependent: :destroy
  has_many :proposals, dependent: :destroy

  enum user_type: [ :Client, :Engineer ]

  def country_name
  	c = ISO3166::Country[country]
  	c.translations[I18n.locale.to_s] || c.name
  end

  def to_s
  	self.email
  end
end
