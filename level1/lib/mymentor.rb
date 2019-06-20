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
    @teachers = parsed_data[:teachers]
    @skills = parsed_data[:skills]
  end

  def save_teachers_to_json
    parsed_data = parse_json
    byebug
    parsed_data[:teachers] = @teachers.map do |t|
      { id: t.id,
        firstname: t.firstname,
        lastname: t.lastname,
        skills: t.skills
      }
    end
    File.open(@json_file, "wb") do |f|
      f.write(JSON.pretty_generate(parsed_data))
    end
  end

  def parse_json
    JSON.parse(File.read(@json_file), symbolize_names: true)
  end
end
