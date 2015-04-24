require 'rails_helper'

feature "Create a new todo item" do
  let!(:user) { create(:user) }
  
  before do
    visit(new_user_session_path)
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    
    click_on "Log In"
  end
  
  scenario "form is available on dashboard page" do
    expect(page).to have_field('item_name')
  end
  
  context "is successful" do
    scenario "when user submits a name" do
      fill_in 'item_name', with: "test item"
      click_on "Create Item"
      
      expect(page).to have_content("New item successfully added to list")
      expect(user.items.first.name).to eq('test item')
    end
  end
end