require 'rails_helper'

RSpec.describe '/merchants/:merchant_id/bulk_discounts/:id' do
  describe 'When I vist the bulk discount show page' do
    before do
      @merchant2 = Merchant.create!(name: "Hady's Beach Shack")

      @discount1 = @merchant2.bulk_discounts.create(title: "Small Discount", quantity_threshold: 5, percentage_discount: 20.00)
      @discount2 = @merchant2.bulk_discounts.create(title: "Big Discount", quantity_threshold: 10, percentage_discount: 30.00)
    end

    it 'I see the bulk discount info' do
      visit merchant_bulk_discount_path(@merchant2, @discount1)

      expect(page).to have_content(@discount1.title)
      expect(page).to have_content(@discount1.quantity_threshold)
      expect(page).to have_content(@discount1.percentage_discount)
    end

    it "I should see a link to edit the bulk discount" do
      visit merchant_bulk_discount_path(@merchant2, @discount2)

      expect(page).to have_content("Edit Discount #{@discount2.id}")

      click_link("Edit Discount #{@discount2.id}")

      expect(current_path).to eq("/merchants/#{@merchant2.id}/bulk_discounts/#{@discount2.id}/edit")
    end
  end
end