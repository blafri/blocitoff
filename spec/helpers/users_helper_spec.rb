require 'rails_helper'

describe UsersHelper do
  context ".options_for_timezone" do
    it "returns a properly formatted array to be used as select options" do
      t1 = create(:time_zone, utc_offset: 2)
      t2 = create(:time_zone, utc_offset: -1)

      expect(helper.options_for_timezone).to eq([[t2.description, t2.id], [t1.description, t1.id]])
    end
  end
  
  context ".options_for_email_reminder_days" do
    it "returns a properly formatted array to be used as select options" do
      expect(helper.options_for_email_reminder_days).to eq((1..7).map{ |v| [v, v] })
    end
  end
end