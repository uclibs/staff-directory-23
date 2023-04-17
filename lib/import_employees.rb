require 'csv'

# Open the CSV file and iterate over each row
CSV.foreach('/Users/Lisa/uclibs/staff-directory-23/db/employees.csv', headers: true) do |row|
  # Create a new instance of the model and set its attributes based on the CSV row
  employee = Employee.new(lastname: row['lastname'], firstname: row['firstname'], email: row['email'], phone: row['phone'], title: row['title'])
  
  # Save the record to the database
  employee.save
end
