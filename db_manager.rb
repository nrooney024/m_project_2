require_relative 'person.rb'

class DBManager
  # A class to manage the database of persons
  # Consists of methods to sort the database according to specific attributes
  
  attr_accessor :persons 
  
  def initialize(person_arrays)
    # person_arrays: an array of Person objects (normally created by the FileManager class)
    @persons = person_arrays.flatten # Combining the Person arrays into one
  end


  # Sorts by gender (females before males) then by last name ascending
  def sort_by_gender_and_last_name
    @persons.sort_by { |person| [person.gender, person.last_name] }
  end

  
  # Sorts by birth date, ascending then by last name ascending
  def sort_by_dob_and_last_name  
    @persons.sort_by { |person| [person.dob, person.last_name] }
  end


  # Sorts by last name, descending
  def sort_by_last_name_desc
    @persons.sort_by { |person| person.last_name }.reverse
  end
end