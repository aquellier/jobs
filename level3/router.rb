class Router
  def initialize(teacher_controller, request_controller)
    @teacher_controller = teacher_controller
    @request_controller = request_controller
    @running    = true
  end

  def run
    puts "Welcome to MyMentor project!"

    while @running
      app_features
      action = gets.chomp.to_i
      'hello'
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @teacher_controller.list_teachers
    when 2 then @teacher_controller.create_teacher
    when 3 then @request_controller.list_resquests
    when 4 then @request_controller.create_request
    when 5 then @request_controller.get_price
    when 6 then stop
    else
      puts "Please press 1, 2, 3 or 4"
    end
  end

  def stop
    @running = false
  end

  def app_features
    puts ""
    puts "What do you want to do next?"
    puts "1 - See all teachers"
    puts "2 - Add a teacher"
    puts "3 - See all requests"
    puts "4 - Add a request"
    puts "5 - Get price for a request"
    puts "6 - Close application"
  end
end
