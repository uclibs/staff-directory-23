# frozen_string_literal: true

require 'csv'

# Open the CSV file and iterate over each row
CSV.foreach('/Users/Lisa/uclibs/staff-directory-23/db/departments.csv', headers: true) do |row|
  # Create a new instance of the model and set its attributes based on the CSV row
  department = Department.new(name: row['name'])

  # Save the record to the database
  department.save
end
