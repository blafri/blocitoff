require 'rails_helper'

feature 'Sign UP' do
  let(:first_name) { 'John' }
  let(:last_name) { 'Doe' }
  let(:email) { 'john.doe@example.com' }
  let(:password) { 'Abcd1234' }
  
  scenario "Sign Up page is displayed when you visit users/sign_up" do
    visit(new_user_registration_path)
    expect(page).to have_content('Sign Up')
  end
  
  context "with vaild information" do
    before { ActionMailer::Base.deliveries = [] }
    
    scenario "Successfully signs up and email is sent" do
      
      fill_out_signup_form(
        'user_first_name' => first_name,
        'user_last_name'  => last_name,
        'user_email'      => email,
        'user_password'   => password
      )

      expect(current_path).to eq(root_path)
      expect(page).to have_content('A message with a confirmation link has been sent to your email address')

      # Ensure that an email was sent and that the confirmation link is valid
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries[0].to.include?(email)).to eq(true)
    end
  end
  
  context "with invalid information" do
    scenario "Sign up fails with missing first name" do
      fill_out_signup_form(
        'user_last_name' => last_name,
        'user_email'     => email,
        'user_password'  => password
      )
      
      expect(page).to have_content('First name can\'t be blank')
    end
    
    scenario "signup fails with missing last name" do
      fill_out_signup_form(
        'user_first_name' => first_name,
        'user_email'      => email,
        'user_password'   => password
      )
      
      expect(page).to have_content('Last name can\'t be blank')
    end

    scenario "Signup fails with missing email" do
      fill_out_signup_form(
      'user_first_name' => first_name,
      'user_last_name'  => last_name,
      'user_password'   => password
      )
      
      expect(page).to have_content('Email can\'t be blank')
    end
    
    scenario "Signup fails with missing password" do
      fill_out_signup_form(
        'user_first_name' => first_name,
        'user_last_name'  => last_name,
        'user_email'      => email
      )
      
      expect(page).to have_content('Password can\'t be blank')
    end
    
    scenario "Sign Up fails if you enter and email address that already exists" do
      create(:user, first_name: first_name, last_name: last_name, email: email, password: password)
      
      fill_out_signup_form(
        'user_first_name' => first_name,
        'user_last_name'  => last_name,
        'user_email'      => email,
        'user_password'   => password
      )
      
      expect(page).to have_content('Email has already been taken')
    end
    
    scenario "sign up fails with invalid email" do
      fill_out_signup_form(
        'user_first_name' => first_name,
        'user_last_name'  => last_name,
        'user_email'      => 'invalid_email',
        'user_password'   => password,
      )
      
      expect(page).to have_content("Email is invalid")
    end
  end
end
  
private

def fill_out_signup_form(fields = {})
  visit(new_user_registration_path)

  fields.each_pair do |key, value|
    fill_in key, with: value
  end

  click_on "Sign Up"
end