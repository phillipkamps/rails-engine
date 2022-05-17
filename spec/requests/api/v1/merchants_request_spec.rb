require "rails_helper"

RSpec.describe "Merchants API" do
  it "sends a list of all merchants" do
    get "/api/v1/merchants"

    expect(response).to be_successful
  end
end
