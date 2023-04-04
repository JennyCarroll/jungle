class Order < ApplicationRecord
  #will  return an array of items
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

end
