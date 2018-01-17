require 'rails_helper'

RSpec.feature "UserEdits", type: :feature do
  let(:user) { create(:user) }
  
  scenario "unsuccess edit user" do
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      
      click_link "Setting"
      
      fill_in "Name", with: ""
      fill_in "Email", with: ""
      click_button("Save changes")
      
      expect(page).to have_content "Update your profile"
  end
  
  scenario "success edit user" do
      name = "Anh Nguyen"
      email = "anh@gmail.com"
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      
      click_link "Setting"
      
      fill_in "Name", with: name
      fill_in "Email", with: email

      click_button("Save changes")
      
      expect(current_path).to eql(user_path(user))
      name.eql?(user.name)
      email.eql?(user.email)
  end
  
  scenario "friendly forwarding" do
    visit edit_user_path(user.id)
    
    page.current_url === login_path
    
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    
    current_user = User.find_by(id: user.id)
    expect(current_path).to eql(edit_user_path(current_user))
  end
end
