require 'date'
require_relative 'person.rb'

class FileManager
  # A class to manipulate individual files
  # Includes a class to convert personal data txt files into a lists of Person instances
  
  def initialize(file, delimiter, order)
    @file = file # Path to your txt file of personal data
    @delimiter = delimiter # What the properties of each person in the txt file is delimited by (" ", "|", or ",")
    @order = order # A hash where the keys are personal properties and the value is their index (starting with 0): {last_name: INDEX, first_name: INDEX, gender: INDEX, dob: INDEX, color: INDEX}
    # Configuration for delimiters and their expected formats.
    @delimiter_config = {
      "|" => {
        format: "LastName | FirstName | MiddleInitial | Gender | FavoriteColor | DateOfBirth",
        count: 6
      },
      "," => {
        format: "LastName, FirstName, Gender, FavoriteColor, DateOfBirth",
        count: 5
      },
      " " => {
        format: "LastName FirstName MiddleInitial Gender DateOfBirth FavoriteColor",
        count: 6
      },
      ":" => {
        format: "LastName : FirstName : MiddleInitial : Gender : FavoriteColor : DateOfBirth",
        count: 6
      }
    }
    # For organizing terminal
    @line_break = "\n\n"
    @hash_line = "##############################################################################"
  end

  
  # Creates a string of the params passed into the FileManager class to cleanly see what they are
  def arguments_to_string
    "File: #{file}\n\nDelimiter: #{delimiter}\n\nOrder: #{order}\n\nDate Format: #{date_format}"
  end


  # Creates an array of Person instances based on what has been passed from the input txt file
  def file_to_person_array

    # Here is where we save the Person instances
    persons = []

    File.open(@file, 'r').each_line do |line|

      begin
        # Creates an array of the personal details from each line by stripping the whitespace from the line itself, splitting it by the delimiter, and stripping the whitespace of each individual person detail
        person_args = line.strip.split(@delimiter).map(&:strip)

        # Check if the number of entries matches the expected count for the delimiter
        if person_args.length != @delimiter_config[@delimiter][:count]
          raise ArgumentError, "Incorrect number of properties for delimiter '#{@delimiter}'"
        end

         # Reordering person_args to be in the order stated in ordered_args below
         ordered_args = [:last_name, :first_name, :gender, :dob, :color].map { |attr| person_args[@order[attr]] }

         # Passing the ordered args into a new Person instance and adding it to the persons array
         persons << Person.new(*ordered_args)

        rescue ArgumentError => e
          # Check if the error is because of the property count
          if e.message == "Incorrect number of properties for delimiter '#{@delimiter}'"
            puts @line_break + @hash_line + @line_break +
              "file_to_person_array ARGUMENT ERROR" + @line_break +
              "Invalid line format or delimiter:" + @line_break +
              "File: #{@file}" + @line_break +
              "Line: #{line}" + @line_break +
              "Expected format: #{@delimiter_config[@delimiter][:format]}" + @line_break + @hash_line + @line_break
          
          # ArgumentError log, if ArgumentError isn't triggered by the wrong property count
          else
            puts @line_break + @hash_line + @line_break +
            "file_to_person_array ARGUMENT ERROR" + @line_break + 
            "Location of error below:" + @line_break +
            "File: #{@file}" + @line_break +
            "Line: #{line}" 
            "Error message: " + e.message + @line_break + @hash_line + @line_break
          end

        # Returning error message for unexpected error
        rescue StandardError => e
          puts @line_break + @hash_line + @line_break +
          "file_to_person_array UNEXPECTED ERROR" + @line_break +
          "There was an unexpected error in the following line, so it was skipped:" + @line_break +
          "File: #{@file}" + @line_break +
          "Line: #{line}." + @line_break +
          "Error message: #{e.message}" + @line_break + @hash_line + @line_break
      end
    end

    # When it's done running through the file, it returns an array of each Person instance created
    persons
  end
end
