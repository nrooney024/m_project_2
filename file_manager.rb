require 'date'
require_relative 'person.rb'

class FileManager
  # A class to manipulate individual files
  # Includes a class to convert personal data txt files into a lists of Person instances
  
  def initialize(file, delimiter, order)
    @file = file # Path to your txt file of personal data
    @delimiter = delimiter # What the properties of each person in the txt file is delimited by (" ", "|", or ",")
    @order = order # A hash where the keys are personal properties and the value is their index (starting with 0): {last_name: INDEX, first_name: INDEX, gender: INDEX, dob: INDEX, color: INDEX}
  end

  
  # Creates a string of the params passed into the FileManager class to cleanly see what they are
  def arguments_to_string
    return "File: #{file}\n\nDelimiter: #{delimiter}\n\nOrder: #{order}\n\nDate Format: #{date_format}"
  end


  # Creates an array of Person instances based on what has been passed from the input txt file
  def file_to_person_array

    # Here is where we save the Person instances
    persons = []

    File.open(@file, 'r').each_line do |line|

      # Creates an array of the personal details from each line by stripping the whitespace from the line itself, splitting it by the delimiter, and stripping the whitespace of each individual person detail
      person_args = line.strip.split(@delimiter).map(&:strip)

       # Reordering person_args to be in the order stated in ordered_args below
      ordered_args = [:last_name, :first_name, :gender, :dob, :color].map { |attr| person_args[@order[attr]] }

      # Passing the ordered args into a new Person instance and adding it to the persons array
      persons << Person.new(*ordered_args)
    end

    # When it's done running through the file, it returns an array of each Person instance created
    return persons
  end
end