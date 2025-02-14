class Bean < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :brews, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true
  validates :origin, presence: true
  validates :process, presence: true, length: { maximum: 30 }
  validates :roastlevel, presence: true, length: { maximum: 30 }
  validates :rating, numericality: { only_integer: true }, allow_nil: true
  validates :decaf, inclusion: { in: [true, false] }
end
