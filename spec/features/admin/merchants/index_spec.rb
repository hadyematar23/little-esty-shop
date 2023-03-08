require 'rails_helper'

RSpec.describe "admin merchants index", type: :feature do

  before(:each) do
  #   repo_call = File.read('spec/fixtures/repo_call.json')
  #   stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop')
  #   .with(
  #     headers: {
  #       'Accept'=>'*/*',
  #       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #       'Authorization'=>"Bearer #{ENV['github_token']}",
  #       'User-Agent'=>'Faraday v2.7.4'
  #       }
  #   )
  #   .to_return(status: 200, body: repo_call, headers: {})
    
  #   contributors_call = File.read('spec/fixtures/contributors_call.json')
  #   stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop/contributors')
  #   .with(
  #     headers: {
  #       'Accept'=>'*/*',
  #       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #       'Authorization'=>"Bearer #{ENV['github_token']}",
  #       'User-Agent'=>'Faraday v2.7.4'
  #       }
  #   )
  #   .to_return(status: 200, body: contributors_call, headers: {})

  #   repo_call = File.read('spec/fixtures/pull_request_call.json')
  #   stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop/pulls?state=closed')
  #   .with(
  #     headers: {
  #       'Accept'=>'*/*',
  #       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #       'Authorization'=>"Bearer #{ENV['github_token']}",
  #       'User-Agent'=>'Faraday v2.7.4'
  #       }
  #   )
  # .to_return(status: 200, body: repo_call, headers: {})

  # commits_call = File.read('spec/fixtures/commits_call.json')
  # stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop/stats/contributors')
  # .with(
  #   headers: {
  #     'Accept'=>'*/*',
  #     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #     'Authorization'=>"Bearer #{ENV['github_token']}",
  #     'User-Agent'=>'Faraday v2.7.4'
  #      }
  # )
  # .to_return(status: 200, body: commits_call, headers: {})


    @merchant1 = Merchant.create!(name: "Mel's Travels")
    @merchant2 = Merchant.create!(name: "Hady's Beach Shack", status: 1)
    @merchant3 = Merchant.create!(name: "Huy's Cheese")
    @merchant4 = Merchant.create!(name: "Beep")
    @merchant5 = Merchant.create!(name: "Ham")
    @merchant6 = Merchant.create!(name: "Mel's Beach Shack")

    @customer1 = Customer.create!(first_name: "Steve", last_name: "Stevinson")

    @invoice1 = Invoice.create!(customer: @customer1, status: 1, created_at: "01/01/2023".to_date) #completed
    @invoice2 = Invoice.create!(customer: @customer1, status: 1, created_at: "02/02/2023".to_date) #completed
    @invoice3 = Invoice.create!(customer: @customer1, status: 1, created_at: "10/02/2022".to_date) #completed
    @invoice4 = Invoice.create!(customer: @customer1, status: 1) #completed
    @invoice5 = Invoice.create!(customer: @customer1, status: 1) #completed
    @invoice6 = Invoice.create!(customer: @customer1, status: 1) #completed
    @invoice7 = Invoice.create!(customer: @customer1, status: 1) #completed

    @item1 = Item.create!(name: "Pepper", description: "it is peppery", unit_price: 1150, merchant: @merchant1)
    @item2 = Item.create!(name: "Salt", description: "it is salty", unit_price: 1200, merchant: @merchant2)
    @item3 = Item.create!(name: "Spices", description: "it is spicy", unit_price: 1325, merchant: @merchant3)

    @item4 = Item.create!(name: "Sand", description: "its all over the place", unit_price: 1425, merchant: @merchant4)
    @item5 = Item.create!(name: "Water", description: "see item 1, merchant 1", unit_price: 1500, merchant: @merchant5)
    @item6 = Item.create!(name: "Rum", description: "good for your health", unit_price: 3350, merchant: @merchant6)

    @ii1 = InvoiceItem.create!(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 12000) 
    @ii2 = InvoiceItem.create!(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 10000) 
    @ii1 = InvoiceItem.create!(item: @item3, invoice: @invoice3, quantity: 1, unit_price: 1220) 
    @ii1 = InvoiceItem.create!(item: @item4, invoice: @invoice4, quantity: 1, unit_price: 1130) 
    @ii1 = InvoiceItem.create!(item: @item5, invoice: @invoice5, quantity: 1, unit_price: 1010) 
    @ii1 = InvoiceItem.create!(item: @item6, invoice: @invoice6, quantity: 1, unit_price: 10) 
    @ii1 = InvoiceItem.create!(item: @item1, invoice: @invoice7, quantity: 1, unit_price: 10)

    @transaction1 = @invoice1.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
    @transaction2 = @invoice1.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
    @transaction3 = @invoice2.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
    @transaction4 = @invoice2.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
    @transaction5 = @invoice3.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
    @transaction6 = @invoice4.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
    @transaction7 = @invoice5.transactions.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: "06/29", result: 0) #success
  end

  describe 'merchant index' do
    it 'displays the name of each merchant in the system' do
      visit '/admin/merchants'

      within "#merchant_name-#{@merchant1.id}" do
        expect(page).to have_content("#{@merchant1.name}")
      end
      within "#merchant_name-#{@merchant2.id}" do
        expect(page).to have_content("#{@merchant2.name}")
      end
      within "#merchant_name-#{@merchant3.id}" do
        expect(page).to have_content("#{@merchant3.name}")
      end
    end

    it 'has buttons to disable or enable that merchant' do
      visit '/admin/merchants'
      
      within "#merchant_name-#{@merchant1.id}" do
        expect(page).to have_content("Status: #{@merchant1.status}")
        expect(page).to have_content("Status: enabled")
        expect(page).to have_button("Disable/Enable")
        click_on("Disable/Enable")
      end

      expect(current_path).to eq("/admin/merchants")

      expect(page).to have_content("Status: disabled")
    end

    it 'displays the names of merchants based on their status' do
      visit '/admin/merchants'

      within "#merchants_status-enabled" do
        expect(page).to have_content("#{@merchant1.status}")
      end

      within "#merchants_status-disabled" do
        expect(page).to have_content("#{@merchant2.status}")
      end
    end

    it "displays a link to create a new merchant" do 
      visit '/admin/merchants'

      expect(page).to have_link("Add Merchant", href: "/admin/merchants/new")

    end

    it "displays a link to create a new merchant" do 
      visit '/admin/merchants'

      click_link("Add Merchant")

      expect(current_path).to eq("/admin/merchants/new")

    end

    it 'displays the top 5 merchants along with their revenue earned' do
      visit '/admin/merchants'

      within "#top_5_merchants" do
        expect(page).to have_content("#{@merchant1.name}")
        expect(page).to have_content("#{@merchant1.total_revenue / 100}")
        expect(page).to have_content("#{@merchant2.name}")
        expect(page).to have_content("#{@merchant2.total_revenue / 100}")
        expect(page).to have_content("#{@merchant3.name}")
        expect(page).to have_content("#{@merchant3.total_revenue / 100}")
        expect(page).to have_content("#{@merchant4.name}")
        expect(page).to have_content("#{@merchant4.total_revenue / 100}")
        expect(page).to have_content("#{@merchant5.name}")
        expect(page).to have_content("#{@merchant5.total_revenue / 100}")
      end
    end

    it 'displays the best day the merchant had in sales' do
      visit '/admin/merchants'

      within "#top_5_merchants" do
        expect(page).to have_content("Top selling date for #{@merchant1.name}: #{@merchant1.top_selling_date.format_date}")
        expect(page).to have_content("Top selling date for #{@merchant2.name}: #{@merchant2.top_selling_date.format_date}")
        expect(page).to have_content("Top selling date for #{@merchant3.name}: #{@merchant3.top_selling_date.format_date}")
        expect(page).to have_content("Top selling date for #{@merchant4.name}: #{@merchant4.top_selling_date.format_date}")
        expect(page).to have_content("Top selling date for #{@merchant5.name}: #{@merchant5.top_selling_date.format_date}")
      end
    end
  end

end