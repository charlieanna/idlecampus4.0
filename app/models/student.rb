class Student < User
  belongs_to :following_group,:class_name=> 'Group',:foreign_key => 'group_id'
  # validates :group,presence: true
end
