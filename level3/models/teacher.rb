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
      {
        id: id,
        firstname: firstname,
        lastname: lastname
      }
    else
      {
        id: id,
        firstname: firstname,
        lastname: lastname,
        skills: skills.map { |skill| {field: skill[:field].id, level: skill[:level].id} }
      }
    end
  end
end
