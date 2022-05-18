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
    merchants = parsed[:data]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end
end
