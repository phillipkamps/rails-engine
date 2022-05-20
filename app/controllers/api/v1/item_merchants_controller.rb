class Api::V1::ItemMerchantsController < ApplicationController
  def index
    if Item.exists?(params[:item_id])
      item = Item.find(params[:item_id])
      render json: MerchantSerializer.new(item.merchant)
    else
      render status: 404
    end
  end
end
