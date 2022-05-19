require "rails_helper"

RSpec.describe "Items API" do
  let!(:merchant_list) { create_list(:merchant, 3) }
  let!(:item_list) {
    merchant_list.each do |merchant|
      5.times { create :item, {merchant_id: merchant.id} }
    end
  }

  it "gets all items" do
    get "/api/v1/items"
    parsed = JSON.parse(response.body, symbolize_names: true)
    items = parsed[:data]

    expect(response).to be_successful
    expect(items.count).to eq(15)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
    end
  end

  it "gets one item" do
    get "/api/v1/items/#{item_list.first.id}"
    parsed = JSON.parse(response.body, symbolize_names: true)
    item = parsed[:data]

    expect(response).to be_successful
    expect(item[:id]).to eq(item_list.first.id.to_s)
    expect(item[:id]).to_not eq(item_list.last.id.to_s)
  end
end
