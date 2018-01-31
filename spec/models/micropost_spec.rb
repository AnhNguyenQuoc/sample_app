require 'rails_helper'

RSpec.describe Micropost, type: :model do
      let(:user) {create(:user)}
      let(:microposts){ user.microposts.build(content: "Lorem ipsum")}
      
      it "is valid" do
        expect(microposts).to be_valid
      end
      
      it "is invalid when user id nil" do
          microposts.user_id = nil
          expect(microposts).to_not be_valid
      end
      
      it "is invalid when content empty" do
          microposts.content = ""
          expect(microposts).to_not be_valid
      end
      
      it "content must be at most 140 characters" do
          microposts.content = "*" * 141
          expect(microposts).to_not be_valid
      end
      
      it "delete when user deleted" do
          micropost = user.microposts.create!(content: "loram 123")
          expect {
              user.destroy
          }.to change(Micropost, :count).by(-1)
      end
end 
