require 'rails_helper'

RSpec.feature "Users", type: :feature do
  
  
  before { ActionMailer::Base.deliveries = [] }
  
  scenario "invalid signup" do
    visit signup_path
    fill_in "Name",with: ""
    fill_in "Email",with: "user@invalid"
    fill_in "Password",with: "foo"
    fill_in "Confirmation",with: "bar"
    expect { click_button 'Create my account' }.to_not change(User, :count)
    expect(page).to have_content("Sign up")
  end
  
  scenario "valid signup" do
      user = {:name => "Example",
                             :email => "user@example.com",
                             :password => "123456",}
      visit signup_path
      fill_in "Name",with: user[:name]
      fill_in "Email",with: user[:email]
      fill_in "Password",with: user[:password]
      fill_in "Confirmation",with: user[:password]
      expect { click_button 'Create my account' }.to change(User, :count)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      
      current_user = User.find_by(id: 1)
      expect(current_user.activated?).to be false
      
      #Login without activation
      visit login_path
      fill_in "Email", with: user[:email]
      fill_in "Password", with: user[:password]
      click_button "Log in"
      expect(page).to have_content "Account not activated.Check your email for the activation link"
      
      activation_token = User.last.activation_digest
      
      #invalid email, valid email
      visit edit_account_activation_path("invalid token", email: current_user.email)
      expect(page).to have_content "Invalid activated link"
      open_email(user[:email])
      current_email.click_link 'Activate'
      
      expect(page).to have_content "Account activated"
      
  end
end
