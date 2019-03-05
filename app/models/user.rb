class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  ## Database authenticatable
  field :email,              type: String, default: ''#, null: false
  field :encrypted_password, type: String, default: ''#, null: false
  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time
  ## Rememberable
  field :remember_created_at, type: Time
  ## Trackable
  field :sign_in_count,      type: Integer, default: 0#, null: false
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time

  field :nickname, type: String
  field :avatar, type: String
  field :slug, type: String

  # has_many :books, as: :bookable, dependent: :nullify
  has_many :registers, dependent: :nullify

  validates :email, presence: true
  validates :password, confirmation: true, length: { in: 6..20 }, on: :create
  validates :password, confirmation: true, allow_blank: true, on: :update
  validates :email, uniqueness: true
  validates :nickname, length: { in: 1..20 }, allow_blank: true
  validates :nickname, uniqueness: { case_sensitive: false }, allow_blank: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable # , :omniauthable, :omniauth_providers => [:google_oauth2]

  # friendly_id :nickname, use: :slugged

  mount_uploader :avatar, AvatarUploader

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

  def will_save_change_to_email?
    false
  end
end
