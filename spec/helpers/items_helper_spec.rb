require 'rails_helper'

describe ItemsHelper do
  context "#time_left_in_words" do
    it "returns 5 days when given an item with 5 days left" do
      item = double(days_left: 5)
      expect(helper.time_left_in_words(item)).to eq('5 Days')
    end
    
    it "returns 1 week when given an item with 7 days left" do
      item = double(days_left: 7)
      expect(helper.time_left_in_words(item)).to eq('1 Week')
    end
    
    it "returns today when given an item with 1 day left" do
      item = double(days_left: 1)
      expect(helper.time_left_in_words(item)).to eq('Today')
    end
  end
end