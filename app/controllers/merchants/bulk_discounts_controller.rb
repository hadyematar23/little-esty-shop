class Merchants::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
    @holiday_info = HolidayFacade.get_three_upcoming_holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.bulk_discounts.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id]) 
  end

  def create
    @merchant = Merchant.find(params[:merchant_id]) 
    discount = @merchant.bulk_discounts.new(bulk_discount_params)

    if discount.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
    else
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/new"
      flash.notice = discount.errors.full_messages.join(", ")
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id]) 
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id]) 
    @discount = BulkDiscount.find(params[:id])
    @discount.update(bulk_discount_params)
    redirect_to merchant_bulk_discount_path(@merchant, @discount)
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id]) 
    @merchant.bulk_discounts.destroy(params[:id])
    redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
  end

  private
  def bulk_discount_params
    params.permit(:title, :percentage_discount, :quantity_threshold)
  end
end