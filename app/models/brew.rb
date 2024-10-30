class Brew < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :user_id, presence: true
  validates :cofamount, presence: true, numericality: { only_integer: true }
  validates :watamount, presence: true, numericality: { only_integer: true }
  validates :method, presence: true, length: { maximum: 30 }
  validates :grindsetting, numericality: { only_integer: true }, allow_nil: true
  validates :temperature, numericality: { only_integer: true }, allow_nil: true
  validates :date, allow_nil: true
  validates :extrationtime, numericality: { only_integer: true }, allow_nil: true
  validates :ratingbrew, numericality: { only_integer: true }, allow_nil: true
  validates :ratingtaste, numericality: { only_integer: true }, allow_nil: true

end
