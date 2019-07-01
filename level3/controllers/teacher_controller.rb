require_relative '../models/teacher'
require_relative '../models/level'
require_relative '../models/field'
require_relative '../mymentor'
require_relative '../views/teacher_view'
require_relative '../services/selection'
# Controller, gets input from router and calls view methods
class TeacherController
  def initialize(mymentor)
    @mymentor = mymentor
    @view = TeacherView.new
    @teachers = @mymentor.all_teachers
    @fields = @mymentor.all_fields
    @levels = @mymentor.all_levels
  end

  # Teachers methods
  def list_teachers
    ::Helper.new.display_teachers(@teachers)
  end

  def create_teacher
    firstname = ::Helper.new.ask_user_for('firstname')
    lastname = ::Helper.new.ask_user_for('lastname')
    id = @teachers.empty? ? 1 : @teachers.last.id + 1
    teacher = Teacher.new(id, firstname, lastname)
    @mymentor.add_teacher(teacher)
    while @view.add_skills_now
      add_skills_to_teacher(teacher)
      @mymentor.save_teachers_to_json
    end
  end

  def add_skills_to_teacher(teacher)
    field = ::Selection.new(@mymentor).select_field
    level = ::Selection.new(@mymentor).select_level
    new_skill = { field: field, level: level }
    if teacher.skills.include? new_skill
      @view.skill_alredy_exists
    else
      teacher.skills << new_skill
    end
  end
end
