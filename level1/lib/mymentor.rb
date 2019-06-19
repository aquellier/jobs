require 'json'

class Mymentor
  def initialize(json_file)
    @json_file = json_file
    @teachers = []
    # load_json if File.exist?(@json_file)
  end

  def all
    return @teachers
  end
end
