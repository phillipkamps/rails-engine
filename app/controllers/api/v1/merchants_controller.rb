class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find_all
    render json: MerchantSerializer.new(Merchant.find_all_by_name(params[:name]))
  end
end
