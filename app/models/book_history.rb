class BookHistory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :book_id, type: Integer
  field :user_id, type: Integer
  field :action, type: String

  belongs_to :book
  belongs_to :user

  validates :book_id, :user_id, :action, presence: true
end
