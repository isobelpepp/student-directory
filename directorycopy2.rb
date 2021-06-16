@students = []

def print_menu
  puts '1. Input the students'
  puts '2. Show the students'
  puts '3. Save the list to students.csv'
  puts '4. Load the list from students.csv'
  puts '9. Exit'
end

def interactive_menu
  loop do
    print_menu
    user_selection($stdin.gets.chomp)
  end
end

def user_selection(selection)
  case selection
  when '1' then input_students
  when '2' then show_students
  when '3' then save_students
  when '4' then load_students
  when '9' then exit
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts 'Please enter the names of the students'
  puts 'To finish just hit return twice'

  name = $stdin.gets.chomp

  until name.empty?
    add_students(name, :november)
    puts "Now we have #{@students.count} students"
    name = $stdin.gets.chomp
  end
end

def add_students(name, cohort)
  @students << { name: name, cohort: cohort }
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts 'The students of Villians Academy'
  puts '-------------'
end

def print_students_list
  @students.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort) " }
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  file = File.open('students.csv', 'w')
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(',')
    file.puts csv_line
  end
  file.close
end

def load_students(filename = 'students.csv')
  file = File.open(filename, 'r')
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    add_students(name, cohort.to_sym)
  end
  file.close
end

def auto_load_students
  filename = ARGV.first

  if filename.nil?
    load_students
    puts "Loaded #{@students.count} from students.csv"
  elsif File.exist?(filename) 
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry #{filename} doesn't exist."
    exit
  end
end

auto_load_students
interactive_menu
