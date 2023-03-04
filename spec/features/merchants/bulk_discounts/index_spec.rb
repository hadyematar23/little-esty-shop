require 'rails_helper'

RSpec.describe '/merchants/:id/discounts' do
  describe 'When I visit the merchants discounts show page' do
    before do
      @merchant2 = Merchant.create!(name: "Hady's Beach Shack")

      @discounts1 = @merchant2.bulk_discounts.create(title: "Small Discount", quantity_threshold: 5, percentage_discount: 20.0)
      @discounts2 = @merchant2.bulk_discounts.create(title: "Big Discount", quantity_threshold: 10, percentage_discount: 30.0)
    end

    it 'I see bulf discount info' do
      visit merchant_bulk_discounts_path(@merchant2)

      expect(page).to have_content("Title: #{@discounts1.title}")
      expect(page).to have_content("Quantity Threshold: #{@discounts1.quantity_threshold}")
      expect(page).to have_content("Percentage Discount: #{@discounts1.percentage_discount}")
      expect(page).to have_content("Title: #{@discounts2.title}")
      expect(page).to have_content("Quantity Threshold: #{@discounts2.quantity_threshold}")
      expect(page).to have_content("Percentage Discount: #{@discounts2.percentage_discount}")
    end

    it 'I see a link by each discount that take me to the discount show page' do
      visit merchant_bulk_discounts_path(@merchant2)

      expect(page).to have_link(@discounts1.title)
      expect(page).to have_link(@discounts2.title)

      click_link(@discounts1.title)

      expect(current_path).to eq("/merchants/#{@merchant2.id}/bulk_discounts/#{@discounts1.id}")
    end

    it 'I should see a link to create a new bulk discount' do
      visit merchant_bulk_discounts_path(@merchant2)

      expect(page).to have_link("New Discount")

      click_link("New Discount")

      expect(current_path).to eq("/merchants/#{@merchant2.id}/bulk_discounts/new")
    end

    it "I should see a link to delete a bulk discount" do
      visit merchant_bulk_discounts_path(@merchant2)

      expect(page).to have_link("Delete Discount #{@discount2}")

      click_link("Delete Discount #{@discount2}")

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant2))
      expect(page).to have_content(@discount1)
      expect(page).to_not have_content(@discount2)
    end

  end
end