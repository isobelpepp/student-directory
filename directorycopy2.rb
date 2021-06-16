@students = []

def print_menu
  puts '1. Input the students'
  puts '2. Show the students'
  puts '3. Save the list of students'
  puts '4. Load a list of student'
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
  when '4' 
    puts 'Name the file you would like to load the list from'
    load_students($stdin.gets.chomp)
  when '9' 
    puts 'You have exited the program'
    exit
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
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
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
  puts 'The students of Makers Academy'
  puts '-------------'
end

def print_students_list
  @students.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort) " }
end

def print_footer
  if @students.count == 1
    puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{@students.count} great student"
  end
end

def save_students
  puts "Please name the file you would like to save the list to"
  filename = gets.chomp
  file = File.open(filename, 'w')
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(',')
    file.puts csv_line
  end
  puts "You have #{@students.count} students saved in #{filename}"
  file.close
end

def load_students(filename)
  if File.exist?(filename)
    file = File.open(filename, 'r')
    file.readlines.each do |line|
      name, cohort = line.chomp.split(',')
      @students << { name: name, cohort: cohort.to_sym }
    end
    puts "You have loaded #{@students.count} students from #{filename}"
    show_students
  else
    puts 'That file does not exist'
    interactive_menu
  end
  file.close
end

def auto_load_students
  filename = ARGV.first
  return if filename.nil?

  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry #{filename} doesn't exist."
    exit
  end
end

auto_load_students
interactive_menu
