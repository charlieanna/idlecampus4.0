class FieldEntry
  def initialize(name, values)
    @name = name
    @values = values
  end

  def to_hash
    field_entry = {}
    field_entry['name'] = @name
    field_entry['values'] = @values.uniq
  end
end
