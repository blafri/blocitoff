require 'rails_helper'

feature "Dashboard" do
  let(:user) { create :user_with_time_zone }
  let(:item) { create :item, user: user, created_at: 2.days.ago.in_time_zone(user.configured_time_zone) }
  
  context 'user has items' do
    before do
      item
      visit(new_user_session_path)
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on "Log In"
    end
    
    scenario "it shows users TODO items list when user has items" do
      expect(page).to have_content(item.name)
      expect(page).to have_content('5 Days')
    end
  end
  
  context 'user has no items' do
    before do
      visit(new_user_session_path)
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on "Log In"
    end
    
    scenario "it shows no TODO items" do
      expect(page).to have_content('Your TODO list is empty. Congratulations.')
    end
  end
end