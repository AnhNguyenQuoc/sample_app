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
    
    describe "DELETE destroy" do
        before :each do
            @user = create(:user)
        end
        
        it "cannot delete without admin" do
            expect{
            delete :destroy, params: { id: @user.id }
            }.to change(User, :count).by(0)
        end
    end
end
