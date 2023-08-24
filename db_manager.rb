require_relative 'person.rb'

class DBManager
  # A class to manage the database of persons
  # Consists of methods to sort the database according to specific attributes
  
  attr_accessor :persons 
  
  def initialize(person_arrays)
    # person_arrays: an array of Person objects (normally created by the FileManager class)
    @persons = person_arrays.flatten # Combining the Person arrays into one
		@line_break = "\n\n" # For organizing the terminal
  end


  # Sorts by gender (females before males) then by last name ascending
  # Passing true will print the sort to the terminal by calling the private method display_sorts_in_terminal
  def sort_by_gender_and_last_name(display_in_terminal = false)
		@persons = @persons.sort_by { |person| [person.gender, person.last_name] }
		display_sorts_in_terminal('sort_by_gender_and_last_name') if display_in_terminal
		@persons
  end

  
  # Sorts by birth date, ascending then by last name ascending
  # Passing true will print the sort to the terminal by calling the private method display_sorts_in_terminal
  def sort_by_dob_and_last_name(display_in_terminal = false)  
		@persons = @persons.sort_by { |person| [person.dob, person.last_name] }
		display_sorts_in_terminal('sort_by_dob_and_last_name') if display_in_terminal
		@persons
  end


  # Sorts by last name, descending
  # Passing true will print the sort to the terminal by calling the private method display_sorts_in_terminal
  def sort_by_last_name_desc(display_in_terminal = false)
		@persons = @persons.sort_by { |person| person.last_name }.reverse
		display_sorts_in_terminal('sort_by_last_name_desc') if display_in_terminal
		@persons
  end


  private

	# Displaying each sort in the terminal
	def display_sorts_in_terminal(sort)
	  messages = {
	    'sort_by_gender_and_last_name' => "Sorted by gender (females before males) then by last name ascending:",
	    'sort_by_dob_and_last_name' => "Sorted by birth date, ascending then by last name ascending:",
	    'sort_by_last_name_desc' => "Sorted by last name, descending:"
	  }
	
	  if messages[sort]
	    puts messages[sort]
	    puts @persons.map(&:to_standardized_string)
	    puts @line_break
	  end
	end

end