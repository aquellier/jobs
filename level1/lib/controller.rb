require_relative 'teacher'
require_relative 'level'
require_relative 'field'
require_relative 'mymentor'
require_relative 'view'
# Controller, gets input from router and calls view methods
class Controller
  def initialize(mymentor)
    @mymentor = mymentor
    @view = View.new
    @teachers = @mymentor.all_teachers
    @fields = @mymentor.all_fields
    @levels = @mymentor.all_levels
  end

  def list_teachers
    @view.display_teachers(@teachers)
  end

  def create
    firstname = @view.ask_user_for('firstname')
    lastname = @view.ask_user_for('lastname')
    id = @teachers.empty? ? 1 : @teachers.last.id + 1
    teacher = Teacher.new(id, firstname, lastname)
    @mymentor.add_teacher(teacher)
    while @view.add_skills_now
      add_skills_to_teacher(teacher)
      @mymentor.save_teachers_to_json
    end
  end

  def add_skills_to_teacher(teacher)
    field = select_field
    level = select_level
    new_skill = { field: field, level: level }
    if teacher.skills.include? new_skill
      @view.skill_alredy_exists
    else
      teacher.skills << new_skill
    end
  end

  private

  def select_field
    field_id = @view.choose_skill(@fields)
    @fields[field_id - 1]
  end

  def select_level
    level_id = @view.choose_level(@levels)
    @levels[level_id - 1]
  end
end
