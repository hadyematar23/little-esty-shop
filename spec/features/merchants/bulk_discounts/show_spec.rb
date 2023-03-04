require 'rails_helper'

RSpec.describe '/merchants/:merchant_id/bulk_discounts/:id' do
  describe 'When I vist the bulk discount show page' do
    before do
      @merchant2 = Merchant.create!(name: "Hady's Beach Shack")

      @discounts1 = @merchant2.bulk_discounts.create(title: "Small Discount", quantity_threshold: 5, percentage_discount: 20.00)
      @discounts2 = @merchant2.bulk_discounts.create(title: "Big Discount", quantity_threshold: 10, percentage_discount: 30.00)
    end

    it 'I see the bulk discount info' do
      visit merchant_bulk_discount_path(@merchant2, @discounts1)

      expect(page).to have_content(@discounts1.title)
      expect(page).to have_content(@discounts1.quantity_threshold)
      expect(page).to have_content(@discounts1.percentage_discount)
    end
  end
end