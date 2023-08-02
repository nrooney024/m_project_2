require 'minitest/autorun'
require_relative '../person'

class TestPerson < Minitest::Test
  def setup
    # Test @person1: includes 'M' & 'mm/dd/yyyy'
    @person1 = Person.new('Smith', 'John', 'M', '01/01/1990', 'Blue')

    # Test @person2: includes 'Female' & 'mm-dd-yyyy'
    @person2 = Person.new('Hingis', 'Martina', 'Female', '4-2-1979', 'Green')
  end

  # Testing the initialization of the Person class
  def test_initialize
    # @person1
    assert_equal('Smith', @person1.last_name)
    assert_equal('John', @person1.first_name)
    assert_equal('Male', @person1.gender)
    assert_equal(Date.new(1990, 1, 1), @person1.dob)
    assert_equal('Blue', @person1.color)

    # @person2
    assert_equal('Hingis', @person2.last_name)
    assert_equal('Martina', @person2.first_name)
    assert_equal('Female', @person2.gender)
    assert_equal(Date.new(1979, 4, 2), @person2.dob)
    assert_equal('Green', @person2.color)
  end

  
  # Testing the conversion of the Person params to string format
  def test_to_standardized_string
    # @person1 test
    expected_string1 = "Smith John Male 1/1/1990 Blue"
    assert_equal(expected_string1, @person1.to_standardized_string)

    # @person2 test
    expected_string2 = "Hingis Martina Female 4/2/1979 Green"
    assert_equal(expected_string2, @person2.to_standardized_string)
  end

  
  # Testing the conversion of the string date to a date object in mm/dd/yyyy format
  def test_standardize_date
    # Testing dob for @person1 - in mm/dd/yyyy format
    assert_equal(Date.new(1990, 1, 1), @person1.dob)

    # Testing dob for @person2 - in mm-dd-yyyy format
    assert_equal(Date.new(1979, 4, 2), @person2.dob)
  end

  
  # Testing the standardization of gender to "Male" and "Female"
  def test_standardize_gender
    # Testing @person1 - "M"
    assert_equal('Male', @person1.gender)
    
    # Testing @person2 - "Female"
    assert_equal('Female', @person2.gender)
  end
end
