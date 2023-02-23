require 'rails_helper'

RSpec.describe 'Merchant/Items Index Page' do
before(:each) do 
  @merchant1 = Merchant.create!(name: "Hady", uuid: 1) 
  @merchant2 = Merchant.create!(name: "Malena", uuid: 2) 

  @item_1 = @merchant1.items.create(name: "Salt", description: "it is salty", unit_price: 12)
  @item_2 = @merchant1.items.create(name: "Pepper", description: "it is peppery", unit_price: 11)
  @item_3 = @merchant2.items.create(name: "Spices", description: "it is spicy", unit_price: 13)
  @item_4 = @merchant2.items.create(name: "Sand", description: "its all over the place", unit_price: 14)
  @item_5 = @merchant1.items.create(name: "Water", description: "nice and liquidy", unit_price: 15, status: 1)

  @customer_1 = Customer.create(first_name: "Diego", last_name: "Flores")
  @customer_2 = Customer.create(first_name: "Sebastian", last_name: "Beltran")

  @invoice_1 = @customer_1.invoices.create(status: 0)
  @invoice_2 = @customer_1.invoices.create(status: 0)
  @invoice_3 = @customer_1.invoices.create(status: 0)
  
  # InvoiceItem.create(item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: @item_1.unit_price)

end 

  describe "as a merchant" do 
    describe "visit items index page" do 
      it "see link to create new item" do 

        visit "/merchants/#{@merchant1.id}/items"

        expect(page).to have_link("Add Item", href: "/merchants/#{@merchant1.id}/items/new")
      end

      it "click on the link and am taken to a form that allows me to add information" do 

        visit "/merchants/#{@merchant1.id}/items"

        click_link("Add Item")

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")

      end

      it "next to each item i see a button to disable or enable that item" do 

        visit "/merchants/#{@merchant1.id}/items"

        within("div#item_number_#{@item_1.id}") do 
          expect(page).to have_button("Enable/Disable Item #{@item_1.name}")
        end 

      end

      it "when click on that button, am redirected back to the items index and see that the item status has changed" do 

        visit "/merchants/#{@merchant1.id}/items"

        within("div#item_number_#{@item_1.id}") do 
          expect(page).to have_content("Status disabled")
        end 

        within("div#item_number_#{@item_5.id}") do 
          expect(page).to have_content("Status enabled")
        end 

        click_button("Enable/Disable Item #{@item_1.name}")

        click_button("Enable/Disable Item #{@item_5.name}")

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")

        within("div#item_number_#{@item_1.id}") do 
          expect(page).to have_content("Status enabled")
        end 

        within("div#item_number_#{@item_5.id}") do 
          expect(page).to have_content("Status disabled")
        end 


      end
    end
  end 
end 