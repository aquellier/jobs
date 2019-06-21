require_relative 'helper'
require 'date'

class RequestView
  # Requests methods
  def display_requests(requests)
    requests.each do |request|
      puts " #{request.id}/  From #{request.firstname.capitalize} #{request.lastname.upcase},
      #{request.field.name}, grade: #{request.level.grade}"
      if request.teacher
        puts "      teacher: #{request.teacher.firstname.capitalize} #{request.teacher.lastname.upcase}"
        puts "      courses: #{::Helper.new.map_courses(request.courses)}"
      end
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

  def course_date
    puts "Please choose a date with the following format 'mm/dd/yyyy' "
    print '> '
    Date.strptime(gets.chomp, '%m/%d/%Y')
  end

  def add_courses
    puts "Please type 'yes' if you want to take courses with this teacher"
    print "> "
    gets.chomp == "yes"
  end

  def get_request(requests)
    display_requests(requests)
    puts "Please type the number of the request"
    print "> "
    gets.chomp.to_i
  end

  def give_price(price)
    puts "The total price is #{price}€."
  end

  def no_courses
    puts "Sorry there is no course for this request at the moment."
  end

  def start_date
    puts "Startdate:"
    course_date
  end

  def end_date
    puts "Enddate:"
    course_date
  end
end
