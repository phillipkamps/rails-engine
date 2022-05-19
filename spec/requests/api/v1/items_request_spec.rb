require "rails_helper"

RSpec.describe "Items API" do
  it "gets all items" do
    merchants = create_list(:merchant, 3)
    merchants.each { |merchant| 5.times { create :item, {merchant_id: merchant.id} } }

    get "/api/v1/items"
    parsed = JSON.parse(response.body, symbolize_names: true)
    items = parsed[:data]

    expect(response).to be_successful
    expect(items.count).to eq(15)

    # items.each do |item|
    #   expect(item).to have_key(:id)
    #   expect(item[:id]).to be_a(String)
    #
    #   expect(item).to have_key(:type)
    #   expect(item[:type]).to eq("item")
    #
    #   expect(item[:attributes]).to have_key(:name)
    #   expect(item[:attributes][:name]).to be_a(String)
    # end
  end
end
