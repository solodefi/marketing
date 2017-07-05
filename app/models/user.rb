class User < ApplicationRecord
  #verification insert
  before_create :confirmation_token
  #verification insert end
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

  has_many :sent_transactions, :class_name => "Transaction", :foreign_key => :sender_id, dependent: :destroy
  has_many :received_transactions, :class_name => "Transaction", :foreign_key => :recipient_id, dependent: :destroy

  has_many :withdraws, dependent: :destroy
  has_many :deposits, dependent: :destroy

  belongs_to :profession
  serialize :skills, Array

  belongs_to :location

  enum user_type: [ :Client, :Freelancer ]

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :rotation_angle, :zoom_w, :zoom_h, :zoom_x, :zoom_y, :drag_x, :drag_y, :image_backup

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

  def available_balance
    total_earned = self.received_transactions.where(status: 'success').sum(:amount) * 95 / 100
    total_withdraws = self.withdraws.sum(:amount)
    available_balance = total_earned - total_withdraws
  end
  def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
   end
end