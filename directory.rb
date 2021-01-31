require 'csv'
@loaded_filename = ""
@default_filename = "students.csv"
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

def save_students(filename = @default_filename)
  puts "Please enter filename"
  filename = gets.chomp
  CSV.open(filename, "wb") do |csv|
  @students.each do |student|
    csv << [student[:name], student[:cohort]]
  end
  @loaded_filename = filename
  puts "File saved sucessfully to #{filename}!"
  end
end


def load_students(filename = @default_filename)
  if File.exists?(filename)
     CSV.foreach(filename) do |row|
       name, cohort = row
       add_student(name, cohort)
      end
      @loaded_filename = filename
      puts "File loaded sucessfully!"
    else
      if filename == @default_filename
       puts "The default file #{@default_filename} was not found"
       File.write("students.csv", "")
       @loaded_filename = filename
       puts "A new #{@default_filename} was created"
      else
       puts "*** WARNING *** File #{filename} not found"
       puts "Using #{@loaded_filename}"
      end
   end
 end


def try_load_students
  filename = ARGV.first# first argument from the command line
  if filename.nil? # get out of the method if it isn't given
    puts "Loaded students.csv by default"
    @loaded_filename = @default_filename
    load_students(@loaded_filename)
  elsif File.exists?(filename) # if it exists
    @loaded_filename = filename
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

try_load_students
interactive_menu
