require_relative 'helper'

class RequestView
  # Requests methods
  def display_requests(requests)
    requests.each do |request|
      puts "#{request.id} #{request.field.name}, grade: #{request.level.grade}, teacher: #{request.teacher.firstname if request.teacher}"
    end
  end

  def show_qualified_teachers(teachers)
    puts "Here are the teachers avalaible for your request:"
    ::Helper.new.display_teachers(teachers)
  end

  def select_teacher
    puts "Please type the number of the teacher you want to select"
    print "> "
    gets.chomp.to_i
  end

  def no_teacher
    puts "Sorry, no teacher is available for this request"
  end

  # Shared methods
  def ask_user_for(input)
    ::Helper.new.ask_user_for(input)
  end

  def choose_skill(fields)
    ::Helper.new.choose_skill(fields)
  end

  def choose_level(levels)
    ::Helper.new.choose_level(levels)
  end
end
