class BookHistory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: Integer
  field :action, type: String

  embedded_in :book

  validates :user_id, :action, presence: true
end
