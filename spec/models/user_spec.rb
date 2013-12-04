require 'spec_helper'
describe User  do
	before do 
		@user = User.new(name:"ankur",email:"ankothari@gmail.com",password:"akk322",password_confirmation:"akk322")
	end
	subject { @user }
	it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should be_valid }
  
 # it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

   describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

   describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end
  it { should_not be_valid }
  
  end

   describe "when name is already taken" do
    before do
      user_with_same_name = @user.dup
      user_with_same_name.email = "ankothari1@gmail.com"
      user_with_same_name.save
    end
    it { should_not be_valid }
    
 
    
  end

   describe "#send_password_reset" do
    let(:user) { FactoryGirl.build(:user) }

    it "generates a unique password_reset_token each time" do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      user.password_reset_token.should_not eq(last_token)
    end

    it "saves the time the password reset was sent" do
      user.send_password_reset
      user.reload.password_reset_sent_at.should be_present
    end

    it "delivers email to user" do
      user.send_password_reset
      last_email.to.should include (user.email)
    end
  end
  
  describe ".members_without_trailing_" do
    
    it "returns an emptry array when passed an empty array" do
      members = User.members_without_trailing_([])
      expect(members).to eq([])
    end
    
  end
end




















