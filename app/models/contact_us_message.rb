class ContactUsMessage

  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :content, :subject

  validates :name, presence: true
  validates :email, presence: true
  validates :content, presence: true
  validates :subject, presence: true

  


end