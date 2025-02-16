class Bean < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :brews, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :origin, presence: true, length: { maximum: 30 }
  validates :process, presence: true, length: { maximum: 30 }
  validates :roastlevel, presence: true, length: { maximum: 30 }
  validates :rating, numericality: { only_integer: true }, inclusion: { in: 0..5 }, allow_nil: true
  validates :decaf, inclusion: { in: [true, false] }
end
