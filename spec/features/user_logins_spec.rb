require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  let(:user) { create(:user) }
  
  
  scenario 'login with invalid information' do
      visit login_path
      
      expect(page).to have_content("Log in")
      
      fill_in "Email", with: ""
      fill_in "Password", with: ""
      
      click_button "Log in"
      
      expect(page).to have_css("div.alert-danger")
      
      visit root_path
      
      expect(page).to_not have_css("div.alert-danger")
  end
  
  scenario 'login with valid information and logout' do
    visit login_path
    
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      
      click_button "Log in"
      
      expect(page).to have_content("#{user.name}")
      
      page.current_path == root_path
      expect(page).to_not have_link('Login', :href => login_path)
      expect(page).to have_link('Log out', :href => logout_path)
      expect(page).to have_link('Profile', :href => user_path(user))
      
      click_link "Log out"
      
      page.current_path == root_path
      expect(page).to have_link('Log in', :href => login_path)
      expect(page).to_not have_link('Log out', :href => logout_path)
      expect(page).to_not have_link('Profile', :href => user_path(user))
  end
  
  scenario "Remember and delete cookies" do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    
    find(:css, "#session_remember_me[value='1']").set(true)
    
    click_button "Log in"
    
    Capybara.reset_session!
    
    page.reset!
    
    expect(page).to_not have_link("Log in", :href => login_path)
    
    page.driver.browser.clear_cookies
    
    Capybara.reset_session!
    
    page.reset!
    
    visit root_path
    
    expect(page).to have_link("Log in", :href => login_path)
    
  end
end
