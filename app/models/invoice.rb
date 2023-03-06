class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants
  enum status: [ "in progress", "completed", "cancelled" ]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_revenue_for_merchant(merchant)
    invoice_items.where(item_id: merchant.items.ids).sum("unit_price * quantity")
  end

  def self.most_transactions_date
    joins(:transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .order('COUNT(transactions.id)DESC, created_at DESC')
    .limit(1)
  end

  def self.incomplete_invoices
    joins(:invoice_items)
    .where("invoice_items.status != 2")
    .group(:id)
    .order(:created_at)
  end

  def format_date
    created_at.strftime("%F")
  end

  def discount_revenue
    x = invoice_items.
    joins(item: {merchant: :bulk_discounts}).
    select("invoice_items.*, MAX((invoice_items.quantity * invoice_items.unit_price) * bulk_discounts.percentage_discount / 100) AS discount_amount").
    where("invoice_items.quantity >= bulk_discounts.quantity_threshold").
    group(:id)

    x.sum(&:discount_amount)
  end

  def merch_discount_revenue(merchant)
    x = invoice_items.
    joins(item: {merchant: :bulk_discounts}).
    select("invoice_items.*, MAX((invoice_items.quantity * invoice_items.unit_price) * bulk_discounts.percentage_discount / 100) AS discount_amount").
    where(item_id: merchant.items.ids).
    where("invoice_items.quantity >= bulk_discounts.quantity_threshold").
    group(:id)

    x.sum(&:discount_amount)
  end
end