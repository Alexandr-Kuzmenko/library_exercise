class Like
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: Integer
  field :book_id, type: Integer

  belongs_to :book, counter_cache: true
  belongs_to :user

  validates :user, :book, presence: true
  validates_uniqueness_of :user, scope: :book
end
