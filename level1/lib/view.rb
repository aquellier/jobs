class View
  def display(teachers)
    teachers.each do |teacher|
      p "#{teacher.firstname} #{teacher.lastname}"
    end
  end

  def ask_user_for(input)
    puts "#{input.capitalize}?"
    print "> "
    return gets.chomp
  end
end
