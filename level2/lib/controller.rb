require_relative 'teacher'
require_relative 'level'
require_relative 'field'
require_relative 'request'
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
    @requests = @mymentor.all_requests
  end

  # Teachers methods
  def list_teachers
    @view.display_teachers(@teachers)
  end

  def create_teacher
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

  # Requests methods
  def list_resquests
    @view.display_requests(@requests)
  end

  def create_request
    firstname = @view.ask_user_for('firstname')
    lastname = @view.ask_user_for('lastname')
    field = select_field
    level = select_level
    id = @requests.empty? ? 1 : @requests.last.id + 1
    request = Request.new(id, firstname, lastname, field, level)
    @mymentor.add_request(request)
    teachers = qualified_teachers(field, level)
    select_teacher(request, teachers)
  end

  def qualified_teachers(field, level)
    requested_skill = { field: field, level: level }
    @teachers.select { |teacher| teacher.skills.include? requested_skill }
  end

  def select_teacher(request, teachers)
    if teachers.empty?
      @view.no_teacher
    else
      @view.show_qualified_teachers(teachers)
      teacher_index = @view.select_teacher - 1
      @mymentor.update_request(request, @teachers[teacher_index])
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
