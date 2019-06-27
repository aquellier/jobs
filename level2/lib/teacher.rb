# Teacher model
class Teacher
  attr_reader :id, :firstname, :lastname, :skills

  def initialize(id, firstname, lastname, skills = [])
    @id = id
    @firstname = firstname
    @lastname = lastname
    @skills = skills
  end

  def to_json
    if @skills.empty?
      simple_json
    else
      complete_json
    end
  end

  def simple_json
    {
      id: id,
      firstname: firstname,
      lastname: lastname
    }
  end

  def complete_json
    {
      id: id,
      firstname: firstname,
      lastname: lastname,
      skills: skills.map { |skill| { field: skill[:field].id, level: skill[:level].id } }
    }
  end
end
