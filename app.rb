require 'rubygems'
require 'blather/client'

setup ENV['JID'], ENV['JPASSWORD']

# Auto approve subscription requests
subscription :request? do |s|
  write_to_stream s.approve!
end

# Echo back what was said
message :chat?, :body do |m|
  say m.from, "You said: #{m.body}"
end