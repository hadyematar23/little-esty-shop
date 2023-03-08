require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page', type: :feature do

before(:each) do 
#   repo_call = File.read('spec/fixtures/repo_call.json')
#   stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop')
#   .with(
#     headers: {
#       'Accept'=>'*/*',
#       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
#       'Authorization'=>"Bearer #{ENV['github_token']}",
#       'User-Agent'=>'Faraday v2.7.4'
#        }
#   )
#   .to_return(status: 200, body: repo_call, headers: {})
  
#   contributors_call = File.read('spec/fixtures/contributors_call.json')
#   stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop/contributors')
#    .with(
#     headers: {
#       'Accept'=>'*/*',
#       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
#       'Authorization'=>"Bearer #{ENV['github_token']}",
#       'User-Agent'=>'Faraday v2.7.4'
#        }
#   )
#   .to_return(status: 200, body: contributors_call, headers: {})

#   pr_call = File.read('spec/fixtures/pull_request_call.json')

#   stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop/pulls?state=closed')
#   .with(
#     headers: {
#       'Accept'=>'*/*',
#       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
#       'Authorization'=>"Bearer #{ENV['github_token']}",
#       'User-Agent'=>'Faraday v2.7.4'
#        }
#   )
#   .to_return(status: 200, body: pr_call, headers: {})

#   commits_call = File.read('spec/fixtures/commits_call.json')
#   stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop/stats/contributors')
#   .with(
#     headers: {
#       'Accept'=>'*/*',
#       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
#       'Authorization'=>"Bearer #{ENV['github_token']}",
#       'User-Agent'=>'Faraday v2.7.4'
#        }
#   )
#   .to_return(status: 200, body: commits_call, headers: {})

  

  @merchant1 = Merchant.create!(name: "Hady", uuid: 1) 
  @merchant2 = Merchant.create!(name: "Malena", uuid: 2) 

  @item_1 = @merchant1.items.create(name: "Salt", description: "it is salty", unit_price: 12)
  @item_2 = @merchant1.items.create(name: "Pepper", description: "it is peppery", unit_price: 11)
  @item_3 = @merchant2.items.create(name: "Spices", description: "it is spicy", unit_price: 13)
  @item_4 = @merchant2.items.create(name: "Sand", description: "its all over the place", unit_price: 14)
  @item_5 = @merchant2.items.create(name: "Water", description: "see item 1, merchant 1", unit_price: 15)

  @customer_1 = Customer.create(first_name: "Steve", last_name: "Stevinson")
  @customer_2 = Customer.create(first_name: "Steve", last_name: "Stevinson")

  @invoice_1 = @customer_1.invoices.create(status: 0)
  @invoice_2 = @customer_1.invoices.create(status: 0)
  @invoice_3 = @customer_1.invoices.create(status: 0)
  
end 

  describe "as an admin" do 
    describe "visit admin invoices index" do 
      it "see list of invoice IDs in the system" do 

        visit "/admin/invoices"
        # expect(page).to have_content("HuyPhan2025 has 25 number of commits")
        # expect(page).to have_content("MelTravelz has 29 number of commits")
        # expect(page).to have_content("davejm8 has 33 number of commits")
        # expect(page).to have_content("hadyematar23 has 35 number of commits")
        # expect(page).to have_content("hadyematar23")
        # expect("hadyematar23").to appear_before("BrianZanti")
        # expect("BrianZanti").to appear_before("davejm8")
        # expect("davejm8").to appear_before("MelTravelz")
        # expect("MelTravelz").to appear_before("HuyPhan2025")
        # expect("HuyPhan2025").to appear_before("timomitchel")
        # expect("timomitchel").to appear_before("cjsim89")
        # expect("cjsim89").to appear_before("scottalexandra")
        # expect("scottalexandra").to appear_before("jamisonordway")
        # expect("jamisonordway").to appear_before("mikedao")
        # expect(page).to have_content('pull request: 53')
        # expect(page).to have_content('little-esty-shop')
        expect(page).to have_link("Invoice Number #{@invoice_1.id}", href: "/admin/invoices/#{@invoice_1.id}")
        expect(page).to have_link("Invoice Number #{@invoice_2.id}", href: "/admin/invoices/#{@invoice_2.id}")
        expect(page).to have_link("Invoice Number #{@invoice_3.id}", href: "/admin/invoices/#{@invoice_3.id}")
      end
    end
  end 
end 