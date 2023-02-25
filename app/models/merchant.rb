class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  enum status: [ "enabled", "disabled" ]

  def toggle_status
    self.status == "enabled" ? self.disabled! : self.enabled!
  end
end
