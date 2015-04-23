require 'rails_helper'

feature "Sign In" do
  let(:email) { 'john.doe@example.com' }
  let(:password) { 'Abcd1234' }
  
  scenario "sign in page is displayed when you visit user/sign_in" do
    visit(new_user_session_path)
    expect(page).to have_content('Log In')
  end
  
  context "with Valid credentials" do
    let!(:valid_user) { create(:user) }
    
    scenario "successfully logs user in and redirects to their dashboard" do
      fill_out_signin_form(
        'user_email' => email,
        'user_password' => password
      )

      expect(current_path).to eq(root_path)
      expect(page).to have_content('This will be the users dashboard page')
    end
    
    scenario "root page should be users dashboard" do
      fill_out_signin_form(
        'user_email' => email,
        'user_password' => password
      )
      
      visit(root_path)
      expect(page).to have_content('This will be the users dashboard page')
    end
    
    scenario "alert should be shown about no configured timezone when user signs in for first time" do
      fill_out_signin_form(
        'user_email' => email,
        'user_password' => password
      )
      
      expect(page).to have_content('You have not configured a time zone. Please go to account settings and update your profile.')
    end
    
  end
  
  context "with invalid credentials" do
    scenario "fails to log in" do
      fill_out_signin_form(
        'user_email' => email,
        'user_password' => password
      )
      
      expect(page).to have_content('Invalid email or password')
    end
    
    scenario "root page should be landing page" do
      visit (root_path)
      expect(page).to have_content('landing page')
    end
  end
end

feature "Sign out" do
  let(:email) { 'john.doe@example.com' }
  let(:password) { 'Abcd1234' }
  let!(:valid_user) { create(:user) }
  
  scenario "user can signout by clicking the link" do
    fill_out_signin_form(
      'user_email' => email,
      'user_password' => password
    )
    
    within("nav") do
      click_on('Sign Out')
    end
    
    expect(page).to have_content('landing page')
  end
end
  
private

def fill_out_signin_form(fields = {})
  visit(new_user_session_path)

  fields.each_pair do |key, value|
    fill_in key, with: value
  end

  click_on "Log In"
end