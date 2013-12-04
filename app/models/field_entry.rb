class FieldEntry
  def initialize(name, values)
    @name = name
    @values = values
  end

  def to_hash
    { name: @name, values: @values.uniq } 
  end
end
