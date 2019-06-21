class Request
  attr_reader :id, :firstname, :lastname, :field, :level, :teacher, :price_per_hour, :courses

  def initialize(id, firstname, lastname, field, level, teacher = nil, price_per_hour = nil, courses = [])
    @id = id
    @firstname = firstname
    @lastname = lastname
    @field = field
    @level = level
    @teacher = teacher
    @price_per_hour = price_per_hour
    @courses = courses
  end

  def to_json
    if teacher && courses.any?
      {
        id: id,
        firstname: firstname,
        lastname: lastname,
        field: field.id,
        level: level.id,
        teacher: teacher.id,
        price_per_hour: price_per_hour,
        courses: courses
      }
    else
      {
        id: id,
        firstname: firstname,
        lastname: lastname,
        field: field.id,
        level: level.id
      }
    end
  end
end
