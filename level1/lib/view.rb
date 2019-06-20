class View
  def display(teachers)
    teachers.each do |teacher|
      puts "#{teacher.id} -- #{teacher.firstname} #{teacher.lastname}"
      puts "  Skills:"
      puts "  #{teacher.skills}"
    end
  end

  def ask_user_for(input)
    puts "#{input.capitalize}?"
    print "> "
    return gets.chomp
  end

  def ask_skills

  end

  private

  def parse_skills
  end
end
