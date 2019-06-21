require_relative '../mymentor'
require_relative '../models/field'
require_relative '../models/request'
require_relative '../views/helper'

class Selection

  def initialize(mymentor)
    @mymentor = mymentor
    @fields = @mymentor.all_fields
    @levels = @mymentor.all_levels
    @view = Helper.new
  end

  def select_field
    field_id = @view.choose_skill(@fields)
    @fields[field_id - 1]
  end

  def select_level
    level_id = @view.choose_level(@levels)
    @levels[level_id - 1]
  end
end
