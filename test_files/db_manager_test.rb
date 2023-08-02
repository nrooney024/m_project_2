require 'minitest/autorun'
require_relative '../db_manager'
require_relative '../file_manager'
require_relative '../person'

class TestDBManager < Minitest::Test
  def setup

    # Creating Person instances for @person_array1
    @person1 = Person.new('Smith', 'John', 'M', '01/01/1990', 'Blue')
    @person2 = Person.new('Doe', 'Jane', 'F', '02/02/1990', 'Red')

    # Creating @person_array1
    @person_array1 = [@person1, @person2]
    
    # Creating Person instances for @person_array2
    @person3 = Person.new('Hingis', 'Martina', 'Female', '4-2-1979', 'Green')

    @person4 = Person.new('Abercrombie', 'Neil', 'Male', '2/13/1943', 'Tan')

    # Creating @person_array2
    @person_array2 = [@person3, @person4]

    # Creating a test instance of DBManager
    @db_manager = DBManager.new([@person_array1, @person_array2])
  end


  # Check if @db_manager.persons contains the right data after initialization
  def test_initialize 
    expected = [@person1, @person2, @person3, @person4]
    actual = @db_manager.persons
    assert_equal(expected, actual)
  end

  
  # Testing if it's sorted by gender (females before males) then by last name ascending.
  def test_sort_by_gender_and_last_name
    expected = [@person2, @person3, @person4, @person1].map(&:to_standardized_string)
    actual = @db_manager.sort_by_gender_and_last_name.map(&:to_standardized_string)
    assert_equal(expected, actual)
  end


  # Testing if it's sorted by birth date, ascending then by last name ascending
  def test_sort_by_dob_and_last_name
    expected = [@person4, @person3, @person1, @person2].map(&:to_standardized_string)
    actual = @db_manager.sort_by_dob_and_last_name.map(&:to_standardized_string)
    assert_equal(expected, actual)
end


  # Testing if it's sorted by last name, descending
  def test_sort_by_last_name_desc
    expected = [@person1, @person3, @person2, @person4].map(&:to_standardized_string)
    actual = @db_manager.sort_by_last_name_desc.map(&:to_standardized_string)
    assert_equal(expected, actual)
  end

end
