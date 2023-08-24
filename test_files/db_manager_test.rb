require 'minitest/autorun'
require_relative '../db_manager'
require_relative '../file_manager'
require_relative '../person'
require 'stringio'

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


  # This method captures the content printed to the terminal.
  def capture_stdout
    original_stdout = $stdout      # Save the original stdout.
    $stdout = StringIO.new         # Reassign stdout to capture output.
    yield                          # Execute the given block.
    $stdout.string                 # Return captured output.
  ensure
    $stdout = original_stdout      # Reset stdout to its original value.
  end


  # Test to check if the sort_by_last_name_desc method prints the correct 
  # output when the display_in_terminal argument is set to true.
  def test_sort_by_last_name_desc_passing_true 
    output = capture_stdout do     # Capture the terminal output.
      @db_manager.sort_by_last_name_desc(true)
    end
    # Check if the captured output includes the expected sort message.
    assert_includes(output, "Sorted by last name, descending")
  end


  # Test to verify that sort_by_last_name_desc doesn't print anything to 
  # the terminal when display_in_terminal is false, and also checks if the 
  # sorting logic is correct.
  def test_sort_by_last_name_desc_passing_false
    output = capture_stdout do
      sorted_array = @db_manager.sort_by_last_name_desc(false)
      expected_array = [@person1, @person3, @person2, @person4]
      # Check if the returned sorted array matches the expected one.
      assert_equal expected_array, sorted_array
    end
    # Ensure no output was sent to the terminal.
    assert_empty(output)
  end


  # Test to confirm that the display_sorts_in_terminal method displays the 
  # expected output when the sort_by_gender_and_last_name key is provided.
  def test_display_sorts_in_terminal_passing_sort_by_gender_and_last_name
    output = capture_stdout do
      @db_manager.send(:display_sorts_in_terminal,'sort_by_gender_and_last_name')
    end
    assert_includes(output, "Sorted by gender (females before males) then by last name ascending:")
  end


  # Test to verify that the display_sorts_in_terminal method prints the 
  # correct message for the sort_by_dob_and_last_name key.
  def test_display_sorts_in_terminal_passing_sort_by_dob_and_last_name
    output = capture_stdout do
      @db_manager.send(:display_sorts_in_terminal,'sort_by_dob_and_last_name')
    end
    assert_includes(output, "Sorted by birth date, ascending then by last name ascending")
  end


  # Test to see if the display_sorts_in_terminal method displays the 
  # correct message for the sort_by_last_name_desc key.
  def test_display_sorts_in_terminal_passing_sort_by_last_name_desc
    output = capture_stdout do
      @db_manager.send(:display_sorts_in_terminal,'sort_by_last_name_desc')
    end
    assert_includes(output, "Sorted by last name, descending")
  end

end