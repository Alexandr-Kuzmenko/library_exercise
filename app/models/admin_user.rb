class AdminUser
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  ## Database authenticatable
  field :email,              type: String, default: ''#, null: false
  field :encrypted_password, type: String, default: ''#, null: false
  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  field :nickname, type: String
  field :avatar, type: String

  has_many :books, as: :bookable, dependent: :nullify
  has_many :comments, as: :commentable, dependent: :nullify

  validates :email, presence: true
  validates :email, :nickname, uniqueness: true
  validates :password, confirmation: true, length: { in: 6..20 }, on: :create
  validates :password, confirmation: true, length: { in: 6..20 }, allow_blank: true, on: :update
  validates :nickname, uniqueness: { case_sensitive: false }, allow_blank: true

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # mount_uploader :avatar, AvatarUploader

  ## Trackable
  # field :sign_in_count,      type: Integer, default: 0, null: false
  # field :current_sign_in_at, type: Time
  # field :last_sign_in_at,    type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  after_create { |admin| admin.send_reset_password_instructions }
  def password_required?
    new_record? ? false : super
  end
end
