class Brew < ApplicationRecord
  belongs_to :bean

  validates :cofamount, presence: true, numericality: { only_integer: true }
  validates :watamount, presence: true, numericality: { only_integer: true }
  validates :method, presence: true, length: { maximum: 30 }
  validates :grindsetting, numericality: { only_integer: true }, allow_nil: true
  validates :temperature, numericality: { only_integer: true }, allow_nil: true
  validates :extrationtime, numericality: { only_integer: true }, allow_nil: true
  validates :ratingbrew, numericality: { only_integer: true }, allow_nil: true
  validates :brewresult, presence: true, numericality: { only_integer: true }
end
