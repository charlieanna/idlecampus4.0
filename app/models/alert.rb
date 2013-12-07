#
class Alert < ActiveRecord::Base
  belongs_to :group
  belongs_to :article, polymorphic: true
end
