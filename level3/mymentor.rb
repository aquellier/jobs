require 'json'
require 'date'
# Acts as a DB, interaction between data.json and models
class Mymentor
  def initialize(json_file)
    @json_file = json_file
    @teachers = []
    @fields = []
    @levels = []
    @requests = []
    load_json if File.exist?(@json_file)
  end

  def add_teacher(teacher)
    @teachers << teacher
    save_teachers_to_json
  end

  def add_request(request)
    @requests << request
    save_requests_to_json
  end

  def update_request(request, teacher, price_per_hour, courses)
    @requests.delete request
    @requests << Request.new(
      request.id,
      request.firstname,
      request.lastname,
      request.field,
      request.level,
      teacher,
      price_per_hour,
      courses
    )
    save_requests_to_json
  end

  def all_teachers
    @teachers
  end

  def all_fields
    @fields
  end

  def all_levels
    @levels
  end

  def all_requests
    @requests
  end

  def save_teachers_to_json
    parsed_data = parse_json
    parsed_data[:teachers] = @teachers.map(&:to_json)
    save_to_json(parsed_data)
  end

  def save_requests_to_json
    parsed_data = parse_json
    parsed_data[:requests] = @requests.map(&:to_json)
    save_to_json(parsed_data)
  end

  private

  def load_json
    parsed_data = parse_json
    json_fields_to_instances(parsed_data[:fields])
    json_levels_to_instances(parsed_data[:levels])
    json_teachers_to_instances(parsed_data[:teachers])
    json_requests_to_instances(parsed_data[:requests])
  end

  # Teacher methods
  def json_teachers_to_instances(teachers)
    teachers.each do |teacher|
      @teachers << if teacher[:skills]
                     create_complete_teacher_instance(teacher)
                   else
                     create_simple_teacher_instance(teacher)
                   end
    end
  end

  def create_simple_teacher_instance(teacher)
    Teacher.new(
      teacher[:id],
      teacher[:firstname],
      teacher[:lastname]
    )
  end

  def create_complete_teacher_instance(teacher)
    Teacher.new(
      teacher[:id],
      teacher[:firstname],
      teacher[:lastname],
      teacher[:skills].map do |skill|
        { field: @fields[(skill[:field] - 1)], level: @levels[(skill[:level] - 1)] }
      end
    )
  end

  # Field and level methods
  def json_fields_to_instances(fields)
    fields.each do |field|
      @fields << Field.new(
        field[:id],
        field[:name]
      )
    end
  end

  def json_levels_to_instances(levels)
    levels.each do |level|
      @levels << Level.new(
        level[:id],
        level[:grade],
        level[:cycle]
      )
    end
  end

  # Requests methods
  def json_requests_to_instances(requests)
    requests.each do |request|
      @requests << if request[:courses]
                     create_complete_request_instance(request)
                   else
                     create_simple_request_instance(request)
                   end
    end
  end

  def create_simple_request_instance(request)
    Request.new(
      request[:id],
      request[:firstname],
      request[:lastname],
      @fields[(request[:field] - 1)],
      @levels[(request[:level] - 1)]
    )
  end

  def create_complete_request_instance(request)
    Request.new(
      request[:id],
      request[:firstname],
      request[:lastname],
      @fields[(request[:field] - 1)],
      @levels[(request[:level] - 1)],
      @teachers[(request[:teacher] - 1)],
      request[:price_per_hour],
      map_courses(request)
    )
  end

  def map_courses(request)
    request[:courses].map do |course|
      {
        date: Date.strptime(course[:date], '%Y-%m-%d'),
        length: course[:length],
        request_id: course[:request_id]
      }
    end
  end

  def save_to_json(data)
    File.open(@json_file, 'w') do |f|
      f.write(JSON.pretty_generate(data))
    end
  end

  def parse_json
    JSON.parse(File.read(@json_file), symbolize_names: true)
  end
end
