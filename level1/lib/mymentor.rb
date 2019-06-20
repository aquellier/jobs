require 'json'

class Mymentor
  def initialize(json_file)
    @json_file = json_file
    @teachers = []
    @skills = []
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

  def all_skills
    @skills
  end

  private

  def load_json
    parsed_data = parse_json
    convert_json_teachers_to_instances(parsed_data[:teachers])
    @skills = parsed_data[:skills]
  end

  def convert_json_teachers_to_instances(teachers)
    teachers.each do |t|
      @teachers << Teacher.new(t[:id],
                               t[:firstname],
                               t[:lastname],
                               t[:skills]
                              )
    end
  end

  def save_teachers_to_json
    parsed_data = parse_json
    parsed_data[:teachers] = @teachers.map { |teacher| teacher.attributes }
    File.open(@json_file, "wb") do |f|
      f.write(JSON.pretty_generate(parsed_data))
    end
  end

  def parse_json
    JSON.parse(File.read(@json_file), symbolize_names: true)
  end
end
