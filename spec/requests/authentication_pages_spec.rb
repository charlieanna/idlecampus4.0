require 'spec_helper'

describe "AuthenticationPages" do

  describe "Signup" do
    before do
      visit '/'
      user = [*('A'..'Z')].sample(8).join
      click_link "Sign up"
      fill_in "Name",with: user
      fill_in "Email",with: user+"@gmail.com"
      fill_in "registerpassword",with:"akk322"

    end
    let(:submit) { "Create my account" }
    describe "with valid information" do
      it "should create a user" do
       puts response
      end
    end
  end
 
end
