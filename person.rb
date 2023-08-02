require 'date'

class Person
  # A class to standardize personal data
  
  attr_accessor :last_name, :first_name, :gender, :dob, :color

  def initialize(last_name, first_name, gender, dob, color)
    @last_name = last_name
    @first_name = first_name
    @gender = standardize_gender(gender) # ("m", "f", "Male", or "Female") - standardized to "Male" or "Female" when initialized 
    @dob = standardize_date(dob) # in "mm-dd-yyyy" or "mm/dd/yyyy" format - will be standardized to date object in "mm/dd/yyyy" format when initialized
    @color = color
  end

  # Making the properties of the class in a standardized string format
  def to_standardized_string
    return "#{last_name} #{first_name} #{gender} #{dob.strftime('%-m/%-d/%Y')} #{color}"
  end

  # The following is private because they're only needed for initializing the class
  private 

  # Converting "-" separated dates to "/" separated
  def standardize_date(input_date)
    # Setting all dob's to mm/dd/yyyy format
    normalized_date = input_date.gsub('-', '/')
  
    # Try to parse the date
    begin
      Date.strptime(normalized_date, '%m/%d/%Y')
    rescue ArgumentError
      nil # If an error occurs, return nil
    end
  end

  # Converting genders to capitalized, full length versions
  def standardize_gender(gender) 
    case gender.downcase
    when 'm', 'male'
      'Male'
    when 'f', 'female'
      'Female'
    else
      'Unknown' # If it doesn't match "m", "f", "male", or "female", make it "Unknown"
    end    
  end
end