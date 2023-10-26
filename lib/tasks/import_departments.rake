# frozen_string_literal: true


require 'csv'

namespace :import_data do
  desc 'Import departments data from CSV'
  task departments: :environment do
    CSV.foreach('/Users/Lisa/uclibs/staff-directory-23/db/departments.csv', headers: true) do |row|
      department = Department.new(name: row['name'])

      if department.save
        puts "Saved department: #{department.name} successfully."
      else
        puts "Failed to save department: #{department.name}. Errors: #{department.errors.full_messages.join(', ')}"
      end
    end
  end
end
