class Teacher
  attr_reader :id, :firstname, :lastname, :skills

  def initialize(id, firstname, lastname, skills = {})
    @id = id
    @firstname = firstname
    @lastname = lastname
    @skills = skills
  end
end
