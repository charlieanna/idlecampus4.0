class Timetable < ActiveRecord::Base
	belongs_to :group
	has_many :timetable_entries, dependent: :destroy
  has_and_belongs_to_many :fields

  # def to_json(options={})
  # 	"dasda"
  # end
end
