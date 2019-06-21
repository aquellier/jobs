require_relative '../models/teacher'
require_relative '../models/level'
require_relative '../models/field'
require_relative '../models/request'
require_relative '../mymentor'
require_relative '../views/request_view'
require 'byebug'

class RequestController
  def initialize(mymentor)
    @mymentor = mymentor
    @view = RequestView.new
    @teachers = @mymentor.all_teachers
    @fields = @mymentor.all_fields
    @levels = @mymentor.all_levels
    @requests = @mymentor.all_requests
  end

  # Requests methods
  def list_resquests
    @view.display_requests(@requests)
  end

  def create_request
    firstname = @view.ask_user_for("firstname")
    lastname = @view.ask_user_for("lastname")
    field = ::Selection.new(@mymentor).select_field
    level = ::Selection.new(@mymentor).select_level
    id = @requests.empty? ? 1 : @requests.last.id + 1
    request = Request.new(id, firstname, lastname, field, level)
    @mymentor.add_request(request)
    teachers = qualified_teachers(field, level)
    if teachers.empty?
      @view.no_teacher
    else
      @view.show_qualified_teachers(teachers)
      teacher_index = @view.select_teacher - 1
      @mymentor.update_request(request, @teachers[teacher_index])
    end
  end

  def qualified_teachers(field, level)
    requested_skill = { field: field, level: level }
    teachers = @teachers.select { |teacher| teacher.skills.include? requested_skill }
  end
end
