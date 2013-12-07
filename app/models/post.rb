class Post < ActiveRecord::Base
  has_one :message, as: :article
end
