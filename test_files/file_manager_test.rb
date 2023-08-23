require 'minitest/autorun'
require_relative '../file_manager'
require_relative '../person'

class TestFileManager < Minitest::Test
  # Beginning test by creating FileManager instances for each txt file
  def setup
    
    # Test case for file1.txt
    @file_manager1 = FileManager.new('./input_files/file1.txt', ' ', {last_name: 0, first_name: 1, gender: 3, dob: 4, color: 5})
    
    @expected_persons1 = [
      Person.new('Kournikova', 'Anna', 'Female', '6/3/1975', 'Red'),
      Person.new('Hingis', 'Martina', 'Female', '4/2/1979', 'Green'),
      Person.new('Seles', 'Monica', 'Female', '12/2/1973', 'Black')
    ]

    # Test case for file2.txt
    @file_manager2 = FileManager.new('./input_files/file2.txt', '|', {last_name: 0, first_name: 1, gender: 3, dob: 5, color: 4})

    @expected_persons2 = [
      Person.new('Smith', 'Steve', 'Male', '3/3/1985', 'Red'),
      Person.new('Bonk', 'Radek', 'Male', '6/3/1975', 'Green'),
      Person.new('Bouillon', 'Francis', 'Male', '6/3/1975', 'Blue')
    ]

    # Test case for file3.txt
    @file_manager3 = FileManager.new('./input_files/file3.txt', ',', {last_name: 0, first_name: 1, gender: 2, dob: 4, color: 3})
    # Include expected persons for each file
    
    @expected_persons3 = [
      Person.new('Abercrombie', 'Neil', 'Male', '2/13/1943', 'Tan'),
      Person.new('Bishop', 'Timothy', 'Male', '4/23/1967', 'Yellow'),
    ]
  end

  
  def test_file_to_person_array
    # Test person array 1
    test_persons1 = @file_manager1.file_to_person_array
    assert_equal(@expected_persons1.map(&:to_standardized_string), test_persons1.map(&:to_standardized_string))
    
    # Test person array 2
    test_persons2 = @file_manager2.file_to_person_array
    assert_equal(@expected_persons2.map(&:to_standardized_string), test_persons2.map(&:to_standardized_string))
    
    # Test person array 3
    test_persons3 = @file_manager3.file_to_person_array
    assert_equal(@expected_persons3.map(&:to_standardized_string), test_persons3.map(&:to_standardized_string))
  end
end
