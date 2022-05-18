class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantsSerializer.new(Merchant.all)
  end
end
