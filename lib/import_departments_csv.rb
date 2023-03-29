require 'csv'

# Open the CSV file and iterate over each row
CSV.foreach('department-data.csv', headers: true) do |row|
  # Create a new instance of the model and set its attributes based on the CSV row
  department = Department.new(name: row['name'])
  
  # Save the record to the database
  department.save
end
