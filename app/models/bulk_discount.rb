class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  
  validates_presence_of :title, :percentage_discount, :quantity_threshold, presence: true
end
