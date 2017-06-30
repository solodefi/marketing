class Transaction < ApplicationRecord
  belongs_to :sender, :class_name => "User", :foreign_key => :sender_id
  belongs_to :recipient, :class_name => "User", :foreign_key => :recipient_id
  belongs_to :job
  enum status: [ :init, :fail, :success, :pending, :available ]

  validates_numericality_of :amount, greater_than_or_equal_to: 5
end
