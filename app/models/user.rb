class User < ApplicationRecord
  before_save :downcase_email

  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
	attr_accessor :remember_token
	before_save {email.downcase!}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password

  validates :user_name,  presence: true, length: {maximum: Settings.name.maximum}
  validates :email, presence: true, length: {maximum: Settings.email.maximum},
    format: {with: Settings.VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: Settings.password.maximum },
    allow_nil: true

  enum role: {user: 0, admin: 1}

  class << self
    def digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
