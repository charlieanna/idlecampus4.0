require_relative '../spec_helper'

describe "HomePage" do
  it "user should see the homepage" do
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

  it "user can see the contact us link" do
    visit '/'
    expect(page).to have_css "a",text:"Contact Us"
  end

  it "user can see the about us link" do
    visit '/'
    expect(page).to have_css "a",text:"About Us"
  end
end