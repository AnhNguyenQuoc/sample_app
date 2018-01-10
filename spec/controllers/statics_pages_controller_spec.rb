require 'rails_helper'

RSpec.describe StaticsPagesController, type: :controller do
    describe "Statics Pages redirect to" do
        it "Redirect to home" do
            visit '/statics/home'
            page.status_code.should == 200
        end
    end
end
