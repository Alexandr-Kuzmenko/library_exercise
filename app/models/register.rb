class Register
  include Mongoid::Document
  include Mongoid::Timestamps

  field :expired, type: Boolean, default: false

  belongs_to :book
  belongs_to :user

  validates :book, :user, :expired, presence: true
end
