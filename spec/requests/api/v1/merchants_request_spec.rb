require "rails_helper"

RSpec.describe "Merchants API" do
  it "gets all merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"
    parsed = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed[:data]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq("merchant")

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "gets one merchant" do
    merchant_list = create_list(:merchant, 3)

    get "/api/v1/merchants/#{merchant_list.first.id}"
    parsed = JSON.parse(response.body, symbolize_names: true)
    merchant = parsed[:data]

    expect(response).to be_successful
    expect(merchant[:id]).to eq(merchant_list.first.id.to_s)
    expect(merchant[:id]).to_not eq(merchant_list.last.id.to_s)
  end

  it "gets all items for a merchant id" do
    merchants = create_list(:merchant, 3)
    3.times { create :item, {merchant_id: merchants[0].id} }
    get "/api/v1/merchants/#{merchants[0].id}/items"
    parsed = JSON.parse(response.body, symbolize_names: true)
    items = parsed[:data]
    expect(response).to be_successful

    items.each do |item|
      expect(item[:attributes][:merchant_id]).to eq(merchants[0].id)
      expect(item[:attributes][:merchant_id]).to_not eq(merchants[1].id)

      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end
end
