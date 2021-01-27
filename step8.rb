def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  puts "Give a name please."
  name = gets.chomp
  puts "Give their hobby please."
  hobby = gets.chomp
  puts "Where are they from?"
  country = gets.chomp
  puts "How tall are they?"
  height = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    if name[0] == "A" && name.length < 12
      students << {name: name, cohort: :november, hobby: hobby, country: country, height: height}
      puts "Now we have #{students.count} students"
    end
    # get another name from the user
    puts "Another name please."
    name = gets.chomp
    if name.empty?
      break
    end
    puts "Their hobby please."
    hobby = gets.chomp
    puts "Where are they from?"
    country = gets.chomp
    puts "How tall are they?"
    height = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  student_counter = 1
  index = 0
  while index <= students.length - 1
    new_arr = students[index]
    puts student_counter.to_s + "." + " #{new_arr[:name]} (#{new_arr[:cohort]} cohort) (#{new_arr[:hobby]} is their hobby) (#{new_arr[:country]} is their birthplace) (#{new_arr[:height]} feet tall)"
    student_counter += 1
    index += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
#nothing happens until we call the methods
print_header
print(students)
print_footer(students)
