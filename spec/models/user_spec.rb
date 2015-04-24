require 'rails_helper'

RSpec.describe User, type: :model do
  context "Validation" do
    it { should validate_presence_of(:email) }
    it { should allow_value('test@example.com', 'test@example.co.tt').for(:email) }
    it { should_not allow_value('test').for(:email) }
    it { should_not allow_value('test@example').for(:email) }

    it { should validate_presence_of(:first_name) }

    it { should validate_presence_of(:last_name) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should belong_to(:time_zone) }
  end
  
  it "#full_name returns users first and last name combined" do
    user = build(:user, first_name: 'rich', last_name: 'froning')
    expect(user.full_name).to eq('Rich Froning')
    
    user = build(:user, first_name: 'Dwayne', last_name: 'de montbrun')
    expect(user.full_name).to eq('Dwayne De Montbrun')
  end
end