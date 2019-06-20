class Teacher
  ATTRIBUTES = [:id, :firstname, :lastname, :skills]
  attr_reader *ATTRIBUTES

  def initialize(id, firstname, lastname, skills = {})
    @id = id
    @firstname = firstname
    @lastname = lastname
    @skills = skills
  end

  # Create attributes method to convert them to json
  def attributes
    values = {}
    ATTRIBUTES.each do |key|
      values[key] = self.send(key)
    end
    values
  end
end
