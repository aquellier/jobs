# Level Model
class Level
  attr_reader :id, :grade, :cycle

  def initialize(id, grade, cycle)
    @id = id
    @grade = grade
    @cycle = cycle
  end
end
