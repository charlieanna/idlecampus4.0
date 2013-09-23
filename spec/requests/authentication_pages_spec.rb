require 'spec_helper'

describe "AuthenticationPages" do

  describe "Signup" do
    before do
      visit '/'
      click_link "Sign up"
      fill_in "Name",with: "Ankur Kothari"
      fill_in "Email",with:"ankothari@gmail.com"
      fill_in "registerpassword",with:"akk322"

    end
    let(:submit) { "Create my account" }
    describe "with valid information" do
      it "should not create a user" do
        expect { click_button submit }.to change(User, :count)
      end
    end
  end
 
end
