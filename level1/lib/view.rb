class View
  def display(teachers)
    teachers.each do |teacher|
      puts "#{teacher.firstname} #{teacher.lastname}"
    end
  end
end
