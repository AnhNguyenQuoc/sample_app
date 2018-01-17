require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe 'access to action' do
        it 'success to new users' do
            visit signup_path
            expect(response).to be_success
        end
        
        it 'redirect index when not login' do
           get :index
           expect(response).to redirect_to('/login')
        end
    end
end
