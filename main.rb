require_relative 'person'
require_relative 'file_manager'
require_relative 'db_manager'

# To help organize the results in the terminal
line_break = "\n\n"


# Creating FileManager instances for each txt file of personal data
file1_manager = FileManager.new('./input_files/file1.txt', ' ', {last_name: 0, first_name: 1, gender: 3, dob: 4, color: 5})
file2_manager = FileManager.new('./input_files/file2.txt', '|', {last_name: 0, first_name: 1, gender: 3, dob: 5, color: 4})
file3_manager = FileManager.new('./input_files/file3.txt', ',', {last_name: 0, first_name: 1, gender: 2, dob: 4, color: 3})
file4_manager = FileManager.new('./input_files/file4.txt', ':', {last_name: 0, first_name: 1, gender: 3, dob: 5, color: 4})


# Creating arrays of Person instances from the personal data in the txt files with file_to_person_array method
file1_persons = file1_manager.file_to_person_array
file2_persons = file2_manager.file_to_person_array
file3_persons = file3_manager.file_to_person_array
file4_persons = file4_manager.file_to_person_array

# Combine all Person arrays into one in DBManager class
db_manager = DBManager.new([file1_persons, file2_persons, file3_persons, file4_persons])


# Sort and display the data using DBManager methods
puts "Output 1: sorted by gender (females before males) then by last name ascending:"

puts db_manager.sort_by_gender_and_last_name.map(&:to_standardized_string)

puts line_break

puts "Output 2: sorted by birth date, ascending then by last name ascending"

puts db_manager.sort_by_dob_and_last_name.map(&:to_standardized_string)

puts line_break

puts "Output 3: sorted by last name, descending"

puts db_manager.sort_by_last_name_desc.map(&:to_standardized_string)
