require_relative 'teacher'
require_relative 'mymentor'
require_relative 'view'
require 'byebug'


class Controller
  def initialize(mymentor)
    @mymentor = mymentor
    @view = View.new
  end

  def list_teachers
    teachers = get_teachers
    @view.display(teachers)
  end

  def create
    teachers = get_teachers
    firstname = @view.ask_user_for("firstname")
    lastname = @view.ask_user_for("lastname")
    id = teachers.empty? ? 1 : teachers.last.id
    teacher = Teacher.new(id, firstname, lastname)
    teachers << teacher
    byebug
    list_teachers
  end

  private

  def get_teachers
    @mymentor.all_teachers
  end
end
