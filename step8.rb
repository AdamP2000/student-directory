def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  puts "Give a name please."
  name = gets.strip
  puts "Are they in the January or November cohort?"
  cohort = gets.strip
  until cohort == "January" || cohort == "November"
    if cohort.empty?
      puts "To be a student they have to be in a cohort so don't leave this blank."
      cohort = gets.strip
    else
      puts "You made a typo, spell the month correctly."
      cohort = gets.strip
    end
  end
  puts "Give their hobby please."
  hobby = gets.strip
  puts "Where are they from?"
  country = gets.strip
  puts "How tall are they?"
  height = gets.strip
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    if name[0] == "A" && name.length < 12
      students << {name: name, cohort: cohort, hobby: hobby, country: country, height: height}
      puts "Now we have #{students.count} students"
    end
    # get another name from the user
    puts "Another name please."
    name = gets.strip
    if name.empty?
      break
    end
    puts "Are they in the January or November cohort?"
    cohort = gets.strip
    until cohort == "January" || cohort == "November"
      if cohort.empty?
        puts "To be a student they have to be in a cohort so don't leave this blank."
        cohort = gets.strip
      else
        puts "You made a typo, spell the month correctly."
        cohort = gets.strip
      end  
    end
    puts "Their hobby please."
    hobby = gets.strip
    puts "Where are they from?"
    country = gets.strip
    puts "How tall are they?"
    height = gets.strip
  end
  # return the array of students
  students
end

def print_header(students)
  if students.count > 0
    puts "The students of Villains Academy".center(148)
    puts "-------------".center(148)
  end
end

def print(students)
  student_counter = 1
  index = 0
  while index <= students.length - 1
    new_arr = students[index]
    puts (student_counter.to_s + "." + " #{new_arr[:name]} (#{new_arr[:cohort]} cohort) (#{new_arr[:hobby]} is their hobby) (#{new_arr[:country]} is their birthplace) (#{new_arr[:height]} feet tall)").center(148)
    student_counter += 1
    index += 1
  end
end

def print_footer(students)
  if students.count > 0
    puts "-------------".center(148)
    if students.count == 1
      puts "Overall, we have #{students.count} great student".center(148)
    else
      puts "Overall, we have #{students.count} great students".center(148)
    end
  end
end

students = input_students
#nothing happens until we call the methods
print_header(students)
print(students)
print_footer(students)
