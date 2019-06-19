require_relative 'teacher'
require_relative 'mymentor'
require_relative 'view'


class Controller
  def initialize(mymentor)
    @mymentor = mymentor
    @view = View.new
  end

  def list
    teachers = @mymentor.all_teachers
    @view.display(teachers)
  end
end
