require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) { create(:user) }
  
  describe "validate user" do
      
      it 'valid' do
        expect(user).to be_valid
      end
      
      it 'name present' do
        user.name = ""
        expect(user).to_not be_valid
      end
      
      it 'name not to long' do
        user.name = "a" * 51
        expect(user).to_not be_valid
      end
      
      it 'email present' do
        user.email = ""
        expect(user).to_not be_valid
      end
      
      it 'email not to long' do
        user.email = "a" * 251
        expect(user).to_not be_valid
      end
      
      it 'email accept valid email' do
        valid_address = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                          first.last@foo.jp alice+bob@baz.cn]
        valid_address.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid
        end
      end
      
      it 'email unaccpet invalid email' do
         invalid_address = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
         invalid_address.each do |invalid_address|
          user.email = invalid_address
          expect(user).to_not be_valid
        end
      end
      
      it 'email unique' do
        dup_user = user.dup
        dup_user.save
        expect(dup_user).to_not be_valid
      end
      
      
      it "password nonblank" do
        user.password = user.password_confirmation = "" * 6
        expect(user).to_not be_valid
      end
      
      it "password minimum length" do
        user.password = user.password_confirmation = "a" * 5
        expect(user).to_not be_valid
      end
  end 
end
