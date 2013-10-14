require "spec_helper"

describe "HomePage" do
  it "user show should see the homepage" do
  	visit '/'
  	expect(page).to have_title "IdleCampus"
  end

  it "user sees the signup link" do
    visit '/'
    expect(page).to have_css "a",text:"Sign Up!"
  end

  it "user sees the signin link" do
  	visit '/'
  	expect(page).to have_css "a",text:"Log In"
  end
end