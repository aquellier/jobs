# View, gets user inputs and displays information
class View
  def display_teachers(teachers)
    teachers.each do |teacher|
      puts "#{teacher.id}./ #{teacher.firstname.capitalize} #{teacher.lastname.upcase}"
      puts '   Skills:'
      teacher_skills(teacher)
    end
  end

  def teacher_skills(teacher)
    teacher.skills.each do |skill|
      puts "   #{skill[:field].name.capitalize}, grade: #{skill[:level].grade}"
    end
  end

  def ask_user_for(input)
    puts "#{input.capitalize}?"
    print '> '
    gets.chomp
  end

  def add_skills_now
    puts "Type 'yes' if you want to new skills to this teacher or any other key otherwise"
    print '> '
    gets.chomp == 'yes'
  end

  def choose_skill(fields)
    puts 'Type the number of the skill you want to add'
    fields.each do |field|
      puts "#{field.id} -- #{field.name}"
    end
    gets.chomp.to_i
  end

  def choose_level(levels)
    puts "Type the number of the teacher's level in this field"
    levels.each do |level|
      puts "#{level.id} -- Grade: #{level.grade}, Cycle #{level.cycle}"
    end
    gets.chomp.to_i
  end

  def skill_alredy_exists
    puts 'Sorry this teacher already has this skill'
    add_skills_now
  end
end
