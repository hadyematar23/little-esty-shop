require 'rails_helper'

RSpec.describe '/merchants/:id/discounts' do
  describe 'When I visit the merchants discounts show page' do
    before do   
      holiday_call = File.read("spec/fixtures/holiday_call.json")
      stub_request(:get, 'https://date.nager.at/api/v3/NextPublicHolidays/US')
      .with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }
      )
      .to_return(status: 200, body: holiday_call, headers: {})
    end

    before do
      @merchant2 = Merchant.create!(name: "Hady's Beach Shack")

      @discount1 = @merchant2.bulk_discounts.create(title: "Small Discount", quantity_threshold: 5, percentage_discount: 20.0)
      @discount2 = @merchant2.bulk_discounts.create(title: "Big Discount", quantity_threshold: 10, percentage_discount: 30.0)
    end

    it 'I see bulf discount info' do
      visit merchant_bulk_discounts_path(@merchant2)

      expect(page).to have_content("Title: #{@discount1.title}")
      expect(page).to have_content("Quantity Threshold: #{@discount1.quantity_threshold}")
      expect(page).to have_content("Percentage Discount: #{@discount1.percentage_discount}")
      expect(page).to have_content("Title: #{@discount2.title}")
      expect(page).to have_content("Quantity Threshold: #{@discount2.quantity_threshold}")
      expect(page).to have_content("Percentage Discount: #{@discount2.percentage_discount}")
    end

    it 'I see a link by each discount that take me to the discount show page' do
      visit merchant_bulk_discounts_path(@merchant2)

      expect(page).to have_link(@discount1.title)
      expect(page).to have_link(@discount2.title)

      click_link(@discount1.title)

      expect(current_path).to eq("/merchants/#{@merchant2.id}/bulk_discounts/#{@discount1.id}")
    end

    it 'I should see a link to create a new bulk discount' do
      visit merchant_bulk_discounts_path(@merchant2)

      expect(page).to have_link("New Discount")

      click_link("New Discount")

      expect(current_path).to eq("/merchants/#{@merchant2.id}/bulk_discounts/new")
    end

    it "I should see a link to delete a bulk discount" do
      visit merchant_bulk_discounts_path(@merchant2)
    
      expect(page).to have_link("Delete Discount #{@discount2.id}")

      click_link("Delete Discount #{@discount2.id}")

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant2))
      expect(page).to have_content(@discount1.title)
      expect(page).to_not have_content(@discount2.title)
    end
  end
end