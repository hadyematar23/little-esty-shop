require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do 
    it { should belong_to :item }
    it { should belong_to :invoice }
    it { should have_many(:customers).through(:invoice) }
    it { should have_many(:transactions).through(:invoice) }
    it { should have_many(:bulk_discounts).through(:item) }
    it { should define_enum_for(:status).with_values(["pending", "packaged", "shipped"]) }
  end

  describe "class methods" do 
    it "is able to get the total revenue made from a singular invoice" do 
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

      @invoice_item1 = FactoryBot.create(:invoice_item, quantity: 1, invoice_id: @invoice_1.id, unit_price: 5, item_id: @item_1.id)
      @invoice_item2 = FactoryBot.create(:invoice_item, quantity: 2, invoice_id: @invoice_1.id, unit_price: 15, item_id: @item_1.id)

      expect(@invoice_1.invoice_items.invoice_total_revenue).to eq(35)
    end

    it 'I should the applied discount' do
      @merchant1 = Merchant.create!(name: "Hady", uuid: 1) 
      
      @item_1 = @merchant1.items.create(name: "Salt", description: "it is salty", unit_price: 12)
      @item_2 = @merchant1.items.create(name: "Pepper", description: "it is peppery", unit_price: 11)
      @item_3 = @merchant1.items.create(name: "Chilli", description: "it is hot", unit_price: 15)
      
      @customer_1 = Customer.create(first_name: "Steve", last_name: "Stevinson")
      
      @invoice_1 = @customer_1.invoices.create(status: 0)
      @invoice_2 = @customer_1.invoices.create(status: 0)
      
      @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 10, unit_price: @item_1.unit_price)
      @invoice_item_2 = InvoiceItem.create!(item: @item_3, invoice: @invoice_1, quantity: 20, unit_price: @item_3.unit_price)
      
      @discount1 = @merchant1.bulk_discounts.create(title: "Small Discount", quantity_threshold: 5, percentage_discount: 20.0)
      @discount2 = @merchant1.bulk_discounts.create(title: "Big Discount", quantity_threshold: 15, percentage_discount: 30.0)
      
      expect(@invoice_item_1.applied_discount).to eq(@discount1)
    end
  end
end
