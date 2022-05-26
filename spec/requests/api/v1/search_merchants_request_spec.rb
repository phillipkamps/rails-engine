require "rails_helper"

RSpec.describe "Merchants API" do
  let!(:merchant_list) { create_list(:merchant, 3) }
  let!(:item_list) {
    merchant_list.map do |merchant|
      create_list :item, 5, {merchant_id: merchant.id}
    end.flatten
  }
  let!(:scotts) { Merchant.create!(name: "Scott's Crab Shack") }
  let!(:phils) { Merchant.create!(name: "Phil's Crab Shack") }

  it "find all merchants by name" do
    get "/api/v1/merchants/find_all?name=shack"
    parsed = JSON.parse(response.body, symbolize_names: true)
    results = parsed[:data]

    expect(response).to be_successful
    expect(results.count).to eq(2)
  end
end
