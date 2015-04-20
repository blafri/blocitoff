require 'rails_helper'

describe ApplicationHelper do
  context ".is_link_active" do
    it "returns 'active' for the links class when on the links page" do
      allow(helper).to receive(:current_page?).and_return(true)
      expect(helper.is_link_active(new_user_session_path)).to eq('active')
    end
    
    it "returns nothing for the links class when not on the links page" do
      allow(helper).to receive(:current_page?).and_return(false)
      expect(helper.is_link_active(new_user_session_path)).to eq('')
    end
  end
  
  context ".link_to_with_icon" do
    it "returns a properly formated link" do
      expect(helper.link_to_with_icon(root_path, {class: 'test'}, text: 'test', icon_name: 'home', tag_class: 'test-in-span')).
        to eq('<a class="test" href="/"><span class="glyphicon glyphicon-home test-in-span" aria-hidden="true"></span> test</a>')
    end
    
    it "returns a properly formated link when optional paramaters are left out" do
      expect(helper.link_to_with_icon(root_path, icon_name: 'home')).
        to eq('<a href="/"><span class="glyphicon glyphicon-home" aria-hidden="true"></span></a>')
    end
  end
end