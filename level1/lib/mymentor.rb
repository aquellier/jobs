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
    json_teachers_to_instances(parsed_data[:teachers])
    json_skills_to_instances(parsed_data[:skills])
  end

  def json_teachers_to_instances(teachers)
    teachers.map! do |teacher|
      Teacher.new(
        teacher[:id],
        teacher[:firstname],
        teacher[:lastname],
        teacher[:skills]
      )
    end
  end

  def json_skills_to_instances(skills)
    skills.map! do |skill|
      Skill.new(
        skill[:id],
        skill[:firstname],
        skill[:lastname],
        skill[:skills]
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
