require 'rails_helper'

describe ApplicationHelper do
  context ".display_form_errors!" do
    it "returns html to display errors" do
      errors_present = double(errors: double(empty?: false, full_messages: ['message1', 'message2']))
      no_errors      = double(errors: double(empty?: true))
      
      expected_output = <<-START
<div class='alert alert-danger'>
  <ul class='list-unstyled'>
    <li>message1</li><li>message2</li>
  </ul>
</div>
START
      
      expect(helper.display_form_errors!(errors_present)).to eq(expected_output)
      expect(helper.display_form_errors!(no_errors)).to eq('')
    end
  end
  
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