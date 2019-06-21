require_relative 'helper'

class TeacherView
  # Teachers methods
  def add_skills_now
    puts "Please type 'yes' if you want to new skills to this teacher or any other key otherwise"
    print "> "
    gets.chomp == "yes"
  end

  def skill_alredy_exists
    puts "Sorry this teacher already has this skill"
    add_skills_now
  end

  # Shared methods

  def display_teachers(teachers)
    ::Helper.new.display_teachers(teachers)
  end

  def ask_user_for(input)
    ::Helper.new.ask_user_for(input)
  end

  def choose_skill(fields)
    ::Helper.new.choose_skill(fields)
  end

  def choose_level(levels)
    ::Helper.new.choose_level(levels)
  end
end
