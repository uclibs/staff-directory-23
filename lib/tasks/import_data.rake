# frozen_string_literal: true

require 'csv'

# Open the CSV file and iterate over each row
namespace :import_data do
  desc 'Import employees data from CSV'
  task employees: :environment do
    require 'csv'

    CSV.foreach('/Users/Lisa/uclibs/staff-directory-23/db/employees.csv', headers: true) do |row|
      employee = Employee.new(
        lastname: row['lastname'],
        firstname: row['firstname'],
        email: row['email'],
        phone: row['phone'],
        title: row['title'],
        department_id: row['department_id'].to_i
      )

      if employee.save
        puts "Saved #{employee.firstname} #{employee.lastname} successfully."
      else
        puts "Failed to save #{employee.firstname} #{employee.lastname}. Errors: #{employee.errors.full_messages.join(', ')}"
      end
    end
  end
end
