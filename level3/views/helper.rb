class Helper
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
    gets.chomp
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

  def map_courses(courses)
    courses.map do |course|
      "#{course[:date]} for #{course[:length]}h"
    end
  end
end
