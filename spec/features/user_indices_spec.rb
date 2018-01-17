require 'rails_helper'

RSpec.feature "UserIndices", type: :feature do
    let(:user) { create(:user) }
    let(:other_user) {create(:other_user) }
    
    scenario "pagination in index" do
        visit login_path
        
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"
          
        click_link "Users"
         
        expect(current_path).to eql(users_path)
        page.has_css?('div.pagination')
        expect(page).to have_link(user.name, :href => user_path(user))
    end
    
    scenario "non admin can't delete" do
        visit login_path
        fill_in "Email", with: other_user.email
        fill_in "Password", with: other_user.password
        click_button "Log in"
        
        visit users_path
        
        expect(page).to_not have_link("delete")
    end
    
end
