class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity].nil?
      render json: {error: "quantity must be present"}, status: 400
    else
      merchants = Merchant.top_merchants_by_revenue(params[:quantity])
      render json: MerchantNameRevenueSerializer.new(merchants)
    end
  end

  def most_items
    merchants = Merchant.top_merchants_by_items_sold(params[:quantity])
    render json: MerchantNameRevenueSerializer.new(merchants)
  end
end
