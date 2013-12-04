require 'spec_helper'

describe Note do
  it "sends to push" do
    group = Group.create(name:"fnsfnsdl")
    Note.new(group:group,note:"fdsfdsf",members:["fdsfsd"]).send_push
  end
end