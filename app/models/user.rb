class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Jobs that you posted
  has_many :jobs, dependent: :destroy
  # Proposals that you sent
  has_many :proposals, dependent: :destroy
  # Jobs that I worked/be working on, as a freelancer
  has_many :freelancing_jobs, :class_name => "Job", :foreign_key => :freelancer_id, dependent: :destroy

  belongs_to :profession
  serialize :skills, Array

  belongs_to :location

  enum user_type: [ :Client, :Freelancer ]

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :rotation_angle, :zoom_w, :zoom_h, :zoom_x, :zoom_y, :drag_x, :drag_y

  mount_uploader :image, ImageUploader

  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false

  def country_name
  	c = ISO3166::Country[country]
  	c.translations[I18n.locale.to_s] || c.name
  end

  def name
    return self.first_name + " " + self.last_name
  end

  def to_s
    name
  end

end