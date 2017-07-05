class InviteFriendsMessage

  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :email, :content

  validates :email, presence: true
  validates :content, presence: true

end