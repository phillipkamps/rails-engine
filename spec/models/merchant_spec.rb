require "rails_helper"

RSpec.describe "Merchant model" do
  describe "class methods" do
    let!(:scotts) { Merchant.create!(name: "Scott's Crab Shack") }
    it "gets all merchants" do
      create_list(:merchant, 3)
      search = Merchant.find_all_by_name("shack")

      expect(search).to eq(scotts)
    end
  end
end
