MONTHS = ['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september',
'october', 'november', 'december']

def input_students

  students = []

  while true do

    puts "Please enter the name and then the cohort of the student."
    puts "To finish please type done"
    
    name = gets.chomp

    if name == 'done'
      break
    end     
      if name.empty?
        puts 'Please enter a valid name'
        name = gets.chomp
      elsif name == 'done'
      break
      end

    cohort = gets.chomp

    while MONTHS.include?(cohort) == false do
    puts 'That is not a valid month, please re-enter'
    cohort = gets.chomp
     if cohort == 'done'
      return name == 'done'
     else
      cohort
     end
    end

    if
    students << {name: name, cohort: cohort}
    puts "Now we have #{students.count} students"
    end

  end

  students

end

def print_header
  puts "The students of Villians Academy"
  puts "-------------"
end

def print(students)
  students.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort) " }
end

def by_cohort(students)
  puts 'If you would like to see a list of people in a cohort please enter the month, if not type done'
  

  while true do
    cohort = gets.chomp
  if cohort == 'done'
    break 

    elsif MONTHS.include?(cohort) == false
      puts 'That is not a valid month, please re-enter'

    elsif MONTHS.include?(cohort)
    
      if students.map { |student| cohort == student[:cohort] }.count < 1
      puts 'There is no-one in this cohort'
    else
      students.map { |student| puts student[:name] if cohort == student[:cohort] }
    end
  
    end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
by_cohort(students)

