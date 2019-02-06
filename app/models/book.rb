class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  # extend FriendlyId

  field :name, type: String
  field :author, type: String
  field :envelope, type: String#, null: false
  field :description, type: String
  field :status, type: Boolean, default: true
  field :likes_count, type: Integer, default: 0

  field :slug, type: String

  has_many :book_histories
  has_many :comments
  has_many :likes

  validates :name, presence: true
  validates :name, uniqueness: true

  # embeds_many :likes
  # friendly_id :nickname, use: :slugged

  # mount_uploader :envelope, EnvelopeUploader
end
