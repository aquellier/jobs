require 'json'

class Mymentor
  def initialize(json_file)
    @json_file = json_file
    @teachers = []
    load_json if File.exist?(@json_file)
  end

  def all_teachers
    return @teachers
  end

  private

  def load_json
    parsed_data = JSON.parse(File.read(@json_file))
    @teachers = parsed_data["teachers"]
  end
end
