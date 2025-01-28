class Brew < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :user_id, presence: true
  validates :cofamount, presence: true, numericality: { only_integer: true }
  validates :watamount, presence: true, numericality: { only_integer: true }
  validates :method, presence: true, length: { maximum: 30 }
  validates :grindsetting, numericality: { only_integer: true }, allow_nil: true
  validates :temperature, numericality: { only_integer: true }, allow_nil: true
  validates :date, allow_nil: true, format: {
    with: /\A\d{4}-\d{2}-\d{2}\z/,
    message: 'must be in the format YYYY-MM-DD'
  }
  validates :extrationtime, numericality: { only_integer: true }, allow_nil: true
  validates :ratingbrew, numericality: { only_integer: true }, allow_nil: true
  validates :brewresult, presence: true, numericality: { only_integer: true }
end
