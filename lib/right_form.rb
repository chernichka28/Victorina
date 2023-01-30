module RightForm
  module_function

  def declination(number, form1, form2, form3)
    if (number % 100).between?(5, 20)
      form3
    elsif (number % 10) == 1
        form1
    elsif (number % 10).between?(2, 4)
      form2
    else
      form3
    end
  end
end
