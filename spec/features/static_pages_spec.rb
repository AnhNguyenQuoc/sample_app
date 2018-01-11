require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
   describe 'access to static pages' do
       
        it 'redirect to root page' do
            visit '/'
            page.current_url == '/'
        end    
       
        it 'redirect to home static page' do
            visit 'static_pages/home'
            expect(page).to have_text("Sample App")
            
            expect(page).to have_title "Home | Ruby on Rails Tutorial Sample App"
        end
        
        it 'redirect to about static page' do
            visit 'static_pages/about'
            expect(page).to have_text("About")
            
            expect(page).to have_title "About | Ruby on Rails Tutorial Sample App"
        end
        
        it 'redirect to help static page' do
            visit 'static_pages/help'
            expect(page).to have_text("Help")
            
            expect(page).to have_title "Help | Ruby on Rails Tutorial Sample App"
        end    
    end
end
