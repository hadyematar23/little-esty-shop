class Merchants::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
    @merchant = Merchant.find(params[:merchant_id])
    @distinct_invoices = @merchant.invoices.distinct
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:invoice_id])
    @invoice.invoice_items.update(invoice_params)

    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end

  private
  def invoice_params
    params.permit(:status)
  end
end