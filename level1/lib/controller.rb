require_relative 'teacher'
require_relative 'mymentor'
require_relative 'view'


class Controller
  def initialize(mymentor)
    @mymentor = mymentor
    @view = View.new
  end

  def list
    teachers = @mymentor.all
    @view.display(teachers)
    p "Linking is ok"
  end
end
