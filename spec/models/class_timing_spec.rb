require_relative '../spec_helper'

describe ClassTiming do
	before do
	        from = Time.new

          from = from.change({:hour => 6 , :min => 20})

          to = Time.new

          to = to.change({:hour => 7, :min => 0})



	 @class_timing = ClassTiming.new(:to => to, :from => from)
	end
  
  subject { @class_timing }

  it { should respond_to(:to) }
  it { should respond_to(:from) }

  it {should be_valid}

describe "from should always be less than from" do
  it "should give an error that to is less than from" do
  	      from = Time.new

          from = from.change({:hour => 6 , :min => 30})

          to = Time.new

          to = to.change({:hour => 6, :min => 29})

          class_timing = ClassTiming.new(:to => to, :from => from)
          
          class_timing.valid?
          
          expect(class_timing.errors.full_messages).to include("From should be less than To")
  end
end 
 
 
end