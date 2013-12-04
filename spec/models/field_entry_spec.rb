require 'spec_helper'

describe FieldEntry, '#to_hash' do

   
  it "#returns the right format" do
    
    field_entry_in_hash = FieldEntry.new("room",["a","b","c"]).to_hash
    expect(field_entry_in_hash).to eq({name: "room",values:["a","b","c"]})
    
  end 
end