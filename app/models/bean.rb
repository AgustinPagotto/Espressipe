class Bean < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :brews, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :origin, presence: true, length: { maximum: 30 }, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :process, presence: true, length: { maximum: 30 }, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :roastlevel, presence: true, length: { maximum: 30 }, format: { with: /\A[a-zA-Z\s\-]+\z/, message: "only allows letters, spaces, and hyphens" }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 },
                     allow_nil: true
  validates :decaf, inclusion: { in: [true, false] }
end
