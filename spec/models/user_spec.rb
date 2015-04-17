require 'rails_helper'

RSpec.describe User, type: :model do
  # Validation Tests
  it { should validate_presence_of(:email) }
  it { should allow_value('test@example.com', 'test@example.co.tt').for(:email) }
  it { should_not allow_value('test').for(:email) }
  it { should_not allow_value('test@example').for(:email) }

  it { should validate_presence_of(:first_name) }

  it { should validate_presence_of(:last_name) }

  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(8) }
end
