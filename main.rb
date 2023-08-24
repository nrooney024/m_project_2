require_relative 'person'
require_relative 'file_manager'
require_relative 'db_manager'

# To help organize the results in the terminal
line_break = "\n\n"

# Configuring how each file should be processed by FileManager
file_configs = [
	['./input_files/file1.txt', ' ', {last_name: 0, first_name: 1, gender: 3, dob: 4, color: 5}],
	['./input_files/file2.txt', '|', {last_name: 0, first_name: 1, gender: 3, dob: 5, color: 4}],
	['./input_files/file3.txt', ',', {last_name: 0, first_name: 1, gender: 2, dob: 4, color: 3}],
	['./input_files/file4.txt', ':', {last_name: 0, first_name: 1, gender: 3, dob: 5, color: 4}],
]

# Construct person arrays from the file configurations by making FileManager instances 
# and calling the file_to_person_array method on them
person_arrays = []
file_configs.each do |file_config|
  person_arrays << FileManager.new(*file_config).file_to_person_array	
end

# Create DB Manager instance
db_manager = DBManager.new(person_arrays)

# Gathering which sorts we'd like to apply
db_sorts = [
	:sort_by_gender_and_last_name,
	:sort_by_dob_and_last_name,
	:sort_by_last_name_desc
]

# Applying sorts and passing true, so we can see the sorts in the terminal
db_sorts.each do |sort_method|
  db_manager.send(sort_method, true) 
end