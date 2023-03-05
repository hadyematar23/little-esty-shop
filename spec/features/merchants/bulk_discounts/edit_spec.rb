require 'rails_helper'

RSpec.describe "/merchants/:merchant_id/bulk_discounts/:bulk_discount_id/edit" do
  describe "When I visit the bulk discount edit page" do
    before do
      @merchant2 = Merchant.create!(name: "Hady's Beach Shack")

      @discount1 = @merchant2.bulk_discounts.create(title: "Small Discount", quantity_threshold: 5, percentage_discount: 20.0)
      @discount2 = @merchant2.bulk_discounts.create(title: "Big Discount", quantity_threshold: 10, percentage_discount: 30.0)
    end

    it "I can edit the bulk discount" do
      visit "/merchants/#{@merchant2.id}/bulk_discounts/#{@discount2.id}/edit"

      expect(page).to have_field(:title, with: "Big Discount")
      expect(page).to have_field(:percentage_discount, with: 30.0)
      expect(page).to have_field(:quantity_threshold, with: 10)

      # click_link("Edit Discount #{@discount2.id}")

      fill_in :percentage_discount, with: 25
      fill_in :quantity_threshold, with: 15

      click_button("Update Discount")

      expect(current_path).to eq("/merchants/#{@merchant2.id}/bulk_discounts/#{@discount2.id}")
      expect(page).to have_content("Big Discount")
      expect(page).to have_content("15")
      expect(page).to have_content("25")
    end
  end
end