require "rails_helper"

RSpec.describe "Merchants API" do
  it "sends a list of all merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(3)
    expect(merchants[:data][0][:id]).to be_a(String)
    expect(merchants[:data][1][:type]).to eq("merchant")
    expect(merchants[:data][2][:attributes][:name]).to be_a(String)
  end
end
