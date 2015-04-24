require 'rails_helper'

feature "Update account" do
  let(:email) { 'john.doe@example.com' }
  let(:password) { 'Abcd1234' }
  
  before do
    create(:user)
    sign_user_in
    visit edit_user_registration_path
  end
  
  scenario "cancel account link deletes the users account" do
    click_on 'Click Here to Cancel'
    
    expect(page).to have_content('Your account was cancel successfully')
    expect(User.find_by(email: email)).to eq(nil)
  end
  
  scenario "email reminder summary x number of days before updates successfully" do
    select 5, from: 'email-days-select'
    click_on 'Update Email Settings'
    
    expect(page).to have_content("Account settings updated successfully.")
    expect(User.find_by(email: email).email_reminders_days).to eq(5)
  end
  
  scenario "email permission settings are updated successfully" do
    uncheck 'allow-email-checkbox'
    click_on 'Update Email Settings'
    
    expect(page).to have_content("Account settings updated successfully.")
    expect(User.find_by(email: email).allow_email_reminders).to eq(false)
  end
  
  scenario "timezone is successfully updated" do
    tz = create :time_zone
    create :time_zone
    create :time_zone

    visit edit_user_registration_path
    
    select tz.description, from: 'user_time_zone_id'
    click_button "Update Profile"
    
    expect(page).to have_content("Account settings updated successfully.")
    expect(User.find_by(email: email).time_zone.name).to eq(tz.name)
  end
  
  scenario "email is successful and email to reconfim is sent" do
    # Empty all emails in the queue
    ActionMailer::Base.deliveries = []

    fill_in 'user_email', with: 'jane.doe@example.com'
    click_button "Update Profile"
    
    expect(page).to have_content(" A confirmation email was sent to \"jane.doe@example.com\". Please follow the email instructions to confirm your new email.")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries[0].to.include?('jane.doe@example.com')).to eq(true)
  end
  
  scenario "email fails when an invalid email is used" do
    fill_in 'user_email', with: 'jane.doe@example'
    click_button "Update Profile"
    
    expect(page).to have_content('There was a problem updating your account')
    expect(page).to have_content('Email is invalid')
    
    fill_in 'user_email', with: 'jane'
    click_button "Update Profile"
    
    expect(page).to have_content('There was a problem updating your account')
    expect(page).to have_content('Email is invalid')
  end
  
  scenario "first and last names are successfully updated" do
    fill_in 'user_first_name', with: 'Rich'
    fill_in 'user_last_name', with: 'Froning'
    click_button "Update Profile"
    
    expect(page).to have_content('Account settings updated successfully.')
    expect(User.find_by(first_name: 'Rich')).not_to eq(nil)
    expect(User.find_by(last_name: 'Froning')).not_to eq(nil)
  end
  
  scenario "reset password link sends an email to reset your password" do
    # Empty all emails in the queue
    ActionMailer::Base.deliveries = []

    click_on "Send Password Reset Email"
    
    expect(page).to have_content("A password reset email has been sent to your email address. Please follow the instruction in the email to change your password")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries[0].to.include?(email)).to eq(true)
  end
end

private

def sign_user_in
  visit(new_user_session_path)
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
    
  click_on "Log In"
end