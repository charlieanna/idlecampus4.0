class TimetableEntrySerializer < ActiveModel::Serializer
  attributes :to_hours, :to_minutes, :from_minutes, :from_hours
  attributes :teacher, :subject, :room, :batch, :weekday
  
  def teacher
    object.teacher.name
  end
  
  def subject
    object.subject.name
  end
  
  def room
    object.room.name
  end
  
  def batch
    object.small_group.name
  end
  
  def weekday
    object.weekday.name
  end
  
 
end
