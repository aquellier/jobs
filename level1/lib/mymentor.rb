require 'json'
# Acts as a DB, interaction between data.json and models
class Mymentor
  def initialize(json_file)
    @json_file = json_file
    @teachers = []
    @fields = []
    @levels = []
    load_json if File.exist?(@json_file)
  end

  def add_teacher(teacher)
    @teachers << teacher
    save_teachers_to_json
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

  def save_teachers_to_json
    parsed_data = parse_json
    parsed_data[:teachers] = @teachers.map(&:to_json)
    File.open(@json_file, 'w') do |f|
      f.write(JSON.pretty_generate(parsed_data))
    end
  end

  private

  def load_json
    parsed_data = parse_json
    json_fields_to_instances(parsed_data[:fields])
    json_levels_to_instances(parsed_data[:levels])
    json_teachers_to_instances(parsed_data[:teachers])
  end

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

  def parse_json
    JSON.parse(File.read(@json_file), symbolize_names: true)
  end
end
