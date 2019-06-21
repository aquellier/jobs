require 'json'
require_relative 'mymentor'
require_relative 'controllers/teacher_controller'
require_relative 'controllers/request_controller'
require_relative 'router'


json_file = File.expand_path('../../data.json', __FILE__)
mymentor = Mymentor.new(json_file)
teacher_controller = TeacherController.new(mymentor)
request_controller = RequestController.new(mymentor)

router = Router.new(teacher_controller, request_controller)

# Start the app
router.run
