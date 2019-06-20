class Request
  attr_reader :id, :field, :level, :teacher

  def initialize(id, field, level, teacher = nil)
    @id = id
    @field = field
    @level = level
    @teacher = teacher
  end

  def to_json
    if teacher
      {
        id: id,
        field: field.id,
        level: level.id,
        teacher: teacher.id
      }
    else
      {
        id: id,
        field: field.id,
        level: level.id
      }
    end
  end
end
