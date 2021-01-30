@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file"
  puts "4. Load the list from file"
  puts "9. Exit" # 9 because we'll be adding more items
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit # this will cause the program to terminate
  when "3"
    save_students
  when "4"
    puts "Enter name of file"
    puts "or leave empty to open default file - students.csv"
    load_name_file = gets.chomp
    load_name_file.empty? ? load_students : load_students(load_name_file)
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  cohort = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    add_student(name, cohort)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
    cohort = STDIN.gets.chomp
  end
end

def show_students
  print_header_student_list
  print_student_list
  print_footer_student_list
end

def print_header_student_list
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer_student_list
  puts "Overall, we have #{@students.count} great students"
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort}
end

def save_students
  puts "Please enter filename"
  filename = gets.chomp
  # open the file for writing
  file = File.open(filename, "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "File saved sucessfully to #{filename}!"
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
  add_student(name, cohort)
  end
  file.close
  puts "File loaded sucessfully!"
end

def try_load_students
  filename = ARGV.first# first argument from the command line
  if filename.nil? # get out of the method if it isn't given
    puts "Loaded students.csv by default"
    load_students()
  elsif File.exists?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

try_load_students
interactive_menu
