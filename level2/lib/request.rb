# Request model
class Request
  attr_reader :id, :firstname, :lastname, :field, :level, :teacher

  def initialize(id, firstname, lastname, field, level, teacher = nil)
    @id = id
    @firstname = firstname
    @lastname = lastname
    @field = field
    @level = level
    @teacher = teacher
  end

  def to_json
    if teacher
      complete_json
    else
      simple_json
    end
  end

  def complete_json
    {
      id: id,
      firstname: firstname,
      lastname: lastname,
      field: field.id,
      level: level.id,
      teacher: teacher.id
    }
  end

  def simple_json
    {
      id: id,
      firstname: firstname,
      lastname: lastname,
      field: field.id,
      level: level.id
    }
  end
end
