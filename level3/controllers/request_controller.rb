require_relative '../models/teacher'
require_relative '../models/level'
require_relative '../models/field'
require_relative '../models/request'
require_relative '../mymentor'
require_relative '../views/request_view'
require 'byebug'
# Request controller, gets input from router and calls view methods
class RequestController
  def initialize(mymentor)
    @mymentor = mymentor
    @view = RequestView.new
    @teachers = @mymentor.all_teachers
    @fields = @mymentor.all_fields
    @levels = @mymentor.all_levels
    @requests = @mymentor.all_requests
  end

  def list_resquests
    @view.display_requests(@requests)
  end

  def create_request
    request = create_base_request
    @mymentor.add_request(request)
    teachers = qualified_teachers(request.field, request.level)
    teacher_index = select_teacher(teachers)
    add_course_to_request(request)
    @mymentor.update_request(request, @teachers[teacher_index], Request::PRICE_PER_HOUR, request.courses)
  end

  def create_base_request
    firstname = ::Helper.new.ask_user_for('firstname')
    lastname = ::Helper.new.ask_user_for('lastname')
    field = ::Selection.new(@mymentor).select_field
    level = ::Selection.new(@mymentor).select_level
    id = @requests.empty? ? 1 : @requests.last.id + 1
    Request.new(id, firstname, lastname, field, level)
  end

  def qualified_teachers(field, level)
    requested_skill = { field: field, level: level }
    @teachers.select { |teacher| teacher.skills.include? requested_skill }
  end

  def select_teacher(teachers)
    if teachers.empty?
      @view.no_teacher
    else
      @view.show_qualified_teachers(teachers)
      @view.select_teacher - 1
    end
  end

  def add_course_to_request(request)
    while @view.add_courses
      date = @view.course_date
      length = ::Helper.new.ask_user_for('Length in hour').to_i
      request.courses << { date: date, length: length, request_id: request.id }
    end
  end

  def price
    request_id = @view.get_request(@requests)
    request = @requests[request_id - 1]
    if request.courses.any?
      price_per_hour = request.price_per_hour
      number_of_hours = request.courses.map { |course| course[:length] }.sum
      @view.give_price(price_per_hour * number_of_hours)
    else
      @view.no_courses
    end
  end

  def price_between_dates
    all_courses = @requests.map(&:courses).flatten
    courses = select_courses(all_courses)
    total_price = courses.map do |course|
      course[:length] * @requests[(course[:request_id] - 1)].price_per_hour
    end.sum
    @view.give_price(total_price)
  end

  def select_courses(courses)
    start_date = @view.start_date
    end_date = @view.end_date
    courses.select do |course|
      start_date < course[:date] && course[:date] < end_date
    end
  end
end
