require 'rails_helper'

feature "Reset Password" do
  let(:email) { 'john.doe@example.com' }
  
  before { ActionMailer::Base.deliveries = [] }
  
  scenario "email is sent when entered email address is found" do
    create(:user)
    
    visit(new_user_password_path)
    fill_in 'user_email', with: email
    click_on 'Send reset password instructions'
    
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('You will receive an email with instructions on how to reset your password in a few minutes.')
    
    # Ensure that an email was sent and that the confirmation link is valid
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries[0].to.include?(email)).to eq(true)
  end
  
  scenario "email is not sent when entered email address is not found" do
    visit(new_user_password_path)
    
    fill_in 'user_email', with: email
    click_on 'Send reset password instructions'
    
    expect(page).to have_content('Email not found')
    expect(ActionMailer::Base.deliveries.count).to eq(0)
  end
end

feature "Confirmation link reset email" do
  let(:email) { 'john.doe@example.com' }
  
  before { ActionMailer::Base.deliveries = [] }
  
  scenario "is sent with a user who has not confirmed his email" do
    # Create unconfirmed user
    create(:user, confirmed_at: '')
    
    # An email would have been sent for creating an unconfirmed
    # user above so reset email hash for test
    ActionMailer::Base.deliveries = []
    
    visit(new_user_confirmation_path)
    fill_in 'user_email', with: email
    click_on 'Resend confirmation instructions'
    
    expect(page).to have_content('You will receive an email with instructions for how to confirm your email address in a few minutes')
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
  
  scenario "is not sent for a user that does not exist" do
    visit(new_user_confirmation_path)
    fill_in 'user_email', with: email
    click_on 'Resend confirmation instructions'
    
    expect(page).to have_content('Email not found')
    expect(ActionMailer::Base.deliveries.count).to eq(0)
  end
  
  scenario "is not sent for a user that has already confirmed his email address" do
    create(:user)
    
    visit(new_user_confirmation_path)
    fill_in 'user_email', with: email
    click_on 'Resend confirmation instructions'
    
    expect(page).to have_content('Email was already confirmed')
    expect(ActionMailer::Base.deliveries.count).to eq(0)
  end
end