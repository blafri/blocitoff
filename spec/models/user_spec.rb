require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "should fail when no email is present" do
      user = build(:user, email: '')
      expect(user.valid?).to eq(false)
    end
    
    it "should fail with an invalid email" do
      user = build(:user, email: 'invalid_email')
      expect(user.valid?).to eq(false)
    end
    
    it "should fail when no first name is present" do
      user = build(:user, first_name: '')
      expect(user.valid?).to eq(false)
    end
    
    it "should fail when no last name is present" do
      user = build(:user, last_name: '')
      expect(user.valid?).to eq(false)
    end
    
    it "should fail when no password is present" do
      user = build(:user, password: '')
      expect(user.valid?).to eq(false)
    end
    
    it "should fail when you password is too short" do
      user = build(:user, password: '1234')
      expect(user.valid?).to eq(false)
    end
  end
end
