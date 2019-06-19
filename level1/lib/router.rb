class Router
  def initialize(controller)
    @controller = controller
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
    when 1 then @controller.list
    when 3 then stop
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
    puts "3 - Close application"
  end
end
