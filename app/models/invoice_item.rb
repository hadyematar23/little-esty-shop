class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :customers, through: :invoice
  has_many :transactions, through: :invoice
  has_many :bulk_discounts, through: :item
  enum status: ["pending", "packaged", "shipped"]

  def self.invoice_total_revenue 
    pluck('SUM(quantity*unit_price)').first
  end

  def applied_discount 
    bulk_discounts.where("bulk_discounts.quantity_threshold <= ?", self.quantity).order(percentage_discount: :desc).first
  end
end
