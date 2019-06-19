class View
  def display(teachers)
    teachers.each do |teacher|
      p "#{teacher['firstname']} #{teacher['lastname']}"
    end
  end
end
