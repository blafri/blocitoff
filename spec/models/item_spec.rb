require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user_with_time_zone) }
  let(:two_day_old_item) { create(:item_2_days_old, user: user) }
  let(:item_with_known_date) { create(:item, user: user, created_at: Time.new(2002, 10, 1, 12).in_time_zone(user.time_zone.name)) }
  let(:ten_day_old_item) { create(:item, created_at: 10.days.ago) }
  
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user) }
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
  
  it "#expiration_date returns the day the item will be deleted" do
    expect(item_with_known_date.expiration_date).to eq(Time.new(2002, 10, 8))
  end
  
  it "#created_at_with_time_zone returns the time the item was created using the configured time zone" do
    expect(item_with_known_date.created_at_with_time_zone).to eq(Time.new(2002, 10, 1, 12).in_time_zone(user.time_zone.name))
  end
end
