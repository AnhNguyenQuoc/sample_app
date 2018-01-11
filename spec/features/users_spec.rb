require 'rails_helper'

RSpec.feature "Users", type: :feature do
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
    visit signup_path
    fill_in "Name",with: "Example"
    fill_in "Email",with: "Example@gmail.com"
    fill_in "Password",with: "123456"
    fill_in "Confirmation",with: "123456"
    expect { click_button 'Create my account' }.to change(User, :count)
    expect(page).to have_content("Welcome to the Sample App!")
  end
end
