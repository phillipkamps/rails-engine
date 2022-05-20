require "rails_helper"

RSpec.describe "Items API" do
  let!(:merchant_list) { create_list(:merchant, 3) }
  let!(:item_list) {
    merchant_list.map do |merchant|
      create_list :item, 5, {merchant_id: merchant.id}
    end.flatten
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

  it "can create a new item" do
    item_params = {
      name: "Ergonomic Wool Hat",
      description: "Fixie cold-pressed iphone pickled.",
      unit_price: 37.55,
      merchant_id: merchant_list[2].id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can destroy an item" do
    item = create(:item, {merchant_id: merchant_list[2].id})
    expect(Item.count).to eq(16)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(15)
    expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can update an item" do
    id = create(:item, {merchant_id: merchant_list[2].id}).id
    previous_name = Item.last.name
    item_params = {name: "Small Wool Table"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Small Wool Table")
  end

  it "gets an item's merchant" do
    get "/api/v1/items/#{item_list[0].id}/merchants"
    parsed = JSON.parse(response.body, symbolize_names: true)
    merchant = parsed[:data]
    expect(response).to be_successful
    expect(merchant[:id]).to eq(merchant_list[0].id.to_s)
    expect(merchant[:id]).to_not eq(merchant_list[1].id.to_s)

    expect(merchant[:attributes][:name]).to eq(merchant_list[0].name)
  end
end
