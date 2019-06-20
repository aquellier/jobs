class Request
  attr_reader :id, :field, :level

  def initialize(id, field, level)
    @id = id
    @field = field
    @level = level
  end

  def to_json
    {
      id: id,
      field: field.id,
      level: level.id
    }
  end
end
