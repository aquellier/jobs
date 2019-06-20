class View
  # Teachers methods
  def display_teachers(teachers)
    teachers.each do |teacher|
      puts "#{teacher.id}./ #{teacher.firstname.capitalize} #{teacher.lastname.upcase}"
      puts "   Skills:"
      teacher.skills.each do |skill|
        puts "   #{skill[:field].name.capitalize}, grade: #{skill[:level].grade}"
      end
    end
  end

  def ask_user_for(input)
    puts "#{input.capitalize}?"
    print "> "
    return gets.chomp
  end

  def add_skills_now
    puts "Please type 'yes' if you want to new skills to this teacher or any other key otherwise"
    print "> "
    gets.chomp == "yes"
  end

  def choose_skill(fields)
    puts "Please type the number of the field you want to choose"
    fields.each do |field|
      puts "#{field.id} -- #{field.name}"
    end
    print "> "
    gets.chomp.to_i
  end

  def choose_level(levels)
    puts "Please type the number of the level you want to choose"
    levels.each do |level|
      puts "#{level.id} -- Grade: #{level.grade}, Cycle #{level.cycle}"
    end
    print "> "
    gets.chomp.to_i
  end

  def skill_alredy_exists
    puts "Sorry this teacher already has this skill"
    add_skills_now
  end

  def display_requests(requests)
    requests.each do |request|
      puts "#{request.id} #{request.field.name}, grade: #{request.level.grade}"
    end
  end
end
