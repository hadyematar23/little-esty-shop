require 'rails_helper'

RSpec.describe "/merchants/:merchant_id/bulk_discounts/new" do
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
  end
  describe "When I visit the new page" do
    describe "I see a form to create a new bulk discount" do
      it "When I fill out the form I will see the new bulk discount in the bulk discount index page" do
        visit "/merchants/#{@merchant2.id}/bulk_discounts/new"

        expect(page).to have_content("Create New Bulk Discount")
        expect(page).to have_field(:title)
        expect(page).to have_field(:percentage_discount)
        expect(page).to have_field(:quantity_threshold)

        fill_in :title, with: "Mega Discount"
        fill_in :percentage_discount, with: 50.0
        fill_in :quantity_threshold, with: 25

        click_button("Create Discount")

        expect(current_path).to eq("/merchants/#{@merchant2.id}/bulk_discounts")
        expect(page).to have_content("Title: Mega Discount")
        expect(page).to have_content("Quantity Threshold: 25")
        expect(page).to have_content("Percentage Discount: 50.0")
      end

      it 'I can not create a new bulk discount without a title' do
        visit "/merchants/#{@merchant2.id}/bulk_discounts/new"

        fill_in :percentage_discount, with: 50.0
        fill_in :quantity_threshold, with: 25

        click_button("Create Discount")
        expect(current_path).to eq("/merchants/#{@merchant2.id}/bulk_discounts/new")
        expect(page).to have_content("Title can't be blank")
        expect(page).to have_button("Create Discount")
      end
    end
  end
end