class MerchantNameRevenueSerializer
  include JSONAPI::Serializer

  attributes :name, :count

  attributes :revenue do |merchant|
    merchant.revenue
  end
end
