class User < ApplicationRecord
  has_many :beans, dependent: :destroy
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine
               .cost
           end
    BCrypt::Password.create(string, cost:)
  end

  # Returns a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  private

  # Converts email to all lowercase
  def downcase_email
    self.email = email.downcase
  end
end
