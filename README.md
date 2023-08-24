# Ruby Parser Challenge

This project parses three different input files, each containing information about different individuals, into a unified format.

## Prerequisites

You will need Ruby installed on your local machine. The project uses Ruby version `3.1.2`. Please ensure you're running this version or newer.

## Getting Started

To get started with the application, clone the repository and navigate into the project directory.

## Running the Application

From the project directory, run the main script to prompt it to solve the given challenge:

`ruby main.rb`

## Class Instructions

### Using FileManager class

`file_manager_instance = FileManager.new('path/to/txt/file', delimiter, {last_name: INDEX, first_name: INDEX, gender: INDEX, dob: INDEX, color: INDEX})`

##### PARAMS
- File: path to your txt file of personal data.
- Delimiter: what the properties of each person in the txt file is delimited by (" ", "|", or ",").
- Order: a hash where the keys are the listed personal properties above and the value is their index (starting with 0).

##### METHODS

###### arguments_to_string
`file_manager_instance.arguments_to_string`

RETURN
- A string containing the arguments passed to the FileManager class, to confirm everything was entered properly.

###### file_to_person_array
`your_person_array = file_manager_instance.file_to_person_array`

RETURN
- This will return an array of instances of the Person class, using the data from your txt file.

---

### Using Person class

(*In the example of the challenge, this is populated by file_to_person_array method of the FileManager class.*)

`person_instance = Person.new('last_name', 'first_name', 'gender', 'dob', 'color')`

##### PARAMS
- last_name: string of person's last name (ex. 'Smith')
- first_name: string of person's first name (ex. 'John')
- gender: string of their gender ("m", "f", "Male", or "Female"), which is standardized to "Male" or "Female" when initialized.
- dob: string of dob in "mm-dd-yyyy" or "mm/dd/yyyy" format that will be standardized to date object in "mm/dd/yyyy" format when initialized.
- color: string of color (ex. 'Blue').

##### METHODS

###### to_standardized_string
`person_instance.to_standardized_string`

RETURN
- A string containing the properties of the Person instance in this format "last_name first_name gender dob color".

---

### Using DBManager class

(*In the example of the challenge, this is populated with what is returned from the file_to_person_array method of the FileManager class.*)

`db_manager_instance = DBManager.new([person_array_1, person_array_2, person_array_3])`

##### PARAMS
- person_arrays: an array of Person arrays gathered from each of your txt files including personal data.

##### METHODS

###### sort_by_gender_and_last_name
`db_manager_instance.sort_by_gender_and_last_name`

PARAM
- display_in_terminal: If this is passed true, it will display your sort method in the terminal. If it's passed false (or left empty), it will not display the sort in the terminal.

RETURN
- An array of Person instances sorted by gender (females before males) then by last name ascending.

###### sort_by_dob_and_last_name
`db_manager_instance.sort_by_dob_and_last_name`

PARAM
- display_in_terminal: If this is passed true, it will display your sort method in the terminal. If it's passed false (or left empty), it will not display the sort in the terminal.

RETURN
- An array of Person instances sorted by birth date, ascending then by last name ascending

###### sort_by_last_name_desc
`db_manager_instance.sort_by_last_name_desc`

PARAM
- display_in_terminal: If this is passed true, it will display your sort method in the terminal. If it's passed false (or left empty), it will not display the sort in the terminal.

RETURN
- An array of Person instances sorted by last name, descending.

## How to Run Tests

Here is how to run your tests from the root folder. Note that these tests are run using Ruby's Minitest from its standard library.

### Running all tests at once:
`ruby run_tests.rb`

### Running TestFileManager individually:
`ruby test_files/file_manager_test.rb`

### Running TestPerson individually:
`ruby test_files/person_test.rb`

### Running TestDBManager individually:
`ruby test_files/db_manager_test.rb`