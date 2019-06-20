require_relative 'teacher'
require_relative 'mymentor'
require_relative 'view'
require 'byebug'


class Controller
  def initialize(mymentor)
    @mymentor = mymentor
    @view = View.new
    @teachers = @mymentor.all_teachers
  end

  def list_teachers
    @view.display(@teachers)
  end

  def create
    firstname = @view.ask_user_for("firstname")
    lastname = @view.ask_user_for("lastname")
    id = @teachers.empty? ? 1 : @teachers.last.id
    teacher = Teacher.new(id, firstname, lastname)
    @mymentor.add_teacher(teacher)
    list_teachers
  end

  private

  def get_skills
    @mymentor.all_skills
  end
end
