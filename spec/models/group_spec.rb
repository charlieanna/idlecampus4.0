require 'spec_helper'

describe Group do
  before do 
    @group = Group.new(name:"Electronics",group_code:"ABCDEF")
  end

  subject {@group}

  it {should respond_to(:name)}
  it {should respond_to(:group_code)}

  describe "when name is not present" do
    before { @group.name = " " }
    it { should_not be_valid }
  end

 describe "when group code is already taken" do
    before do
      group_with_same_code = @group.dup
      group_with_same_code.save
      group_with_same_code1 = @group.dup
      group_with_same_code1.save

    end

    group_codes = []
    
    groups = Group.all
    groups.each do |group|
    group_codes << group.group_code
    expect(group_with_same_code1.group_code).not_to be_within(group_codes)
    end


  end

end
