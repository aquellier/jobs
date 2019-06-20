require 'json'
require_relative 'mymentor'
require_relative 'controller'
require_relative 'router'


json_file = File.expand_path('../../../data.json', __FILE__)
mymentor = Mymentor.new(json_file)
controller = Controller.new(mymentor)

router = Router.new(controller)

# Start the app
router.run
