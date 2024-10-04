class User < ApplicationRecord
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 90 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  private

  # Converts email to all lowercase
  def downcase_email
    self.email = email.downcase
  end
end
