require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
   describe 'access to static pages' do
       
        it 'redirect to root page' do
            visit root_path
            page.current_url == '/'
        end    
       
        it 'redirect to home static page' do
            visit home_path
            expect(page).to have_text("Sample App")
            
            expect(page).to have_title "Home | Ruby on Rails Tutorial Sample App"
        end
        
        it 'redirect to about static page' do
            visit about_path
            expect(page).to have_text("About")
            
            expect(page).to have_title "About | Ruby on Rails Tutorial Sample App"
        end
        
        it 'redirect to help static page' do
            visit help_path
            expect(page).to have_text("Help")
            
            expect(page).to have_title "Help | Ruby on Rails Tutorial Sample App"
        end    
        
        it 'redirect to help static page' do
            visit contact_path
            expect(page).to have_text("Contact")
            
            expect(page).to have_title "Contact | Ruby on Rails Tutorial Sample App"
        end
        
        it 'have link in home page' do
           visit root_path
           
            expect(page).to have_link('Home', :href => root_path)
            expect(page).to have_link('sample app', :href => root_path)
            expect(page).to have_link('About', :href => about_path)
            expect(page).to have_link('Help', :href => help_path)
            expect(page).to have_link('Contact', :href => contact_path)
        end
    end
end
