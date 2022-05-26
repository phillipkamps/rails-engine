class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :transactions
  belongs_to :merchant
end
