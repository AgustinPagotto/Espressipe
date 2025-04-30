class Brew < ApplicationRecord
  belongs_to :bean

  validates :cofamount, presence: true, numericality: { greater_than: 0 }
  validates :watamount, presence: true, numericality: { greater_than: 0 }
  validates :method, presence: true, length: { maximum: 30 }
  validates :grindsetting, numericality: { greater_than: 0 }
  validates :temperature, numericality: { only_integer: true }
  validates :extractiontime, numericality: { only_integer: true }
  validates :ratingbrew, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 },
                         allow_nil: true
  validates :brewresult, presence: true, numericality: { greater_than: 0 }
end
