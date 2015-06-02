require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user_with_time_zone) }
  let(:two_day_old_item) { create(:item_2_days_old, user: user) }
  let(:ten_day_old_item) { create(:item_10_days_old, user: user) }
  
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:expires_at) }
  end
  
  context "relationships" do
    it { should belong_to(:user) }
  end
  
  it "#days_left returns correct number of days left" do
    expect(two_day_old_item.days_left).to eq(5)
  end
  
  it "#days_left returns 0 if there are a negative nuber of days left" do
    expect(ten_day_old_item.days_left).to eq(0)
  end
  
  it "#set_expiration_date sets the expiration date properly" do
    item = user.items.build
    item.set_expiration_date
    expect(item.expires_at).not_to eq(nil)
  end
  
  it "scope expired_items correctly returns expired items" do
    expect(Item.expired_items.count).to eq(0)
    ten_day_old_item
    expect(Item.expired_items.count).to eq(1)
    two_day_old_item
    expect(Item.expired_items.count).to eq(1)
  end
end