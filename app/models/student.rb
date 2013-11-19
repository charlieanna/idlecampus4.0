class Student < User
  belongs_to :group
  validates :group,presence: true
end
