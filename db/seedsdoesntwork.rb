# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb
#alternate:
#department_names = ["CEAS", "Administration", "CCM", "Application Development", "Library IT", "Classics", "HR", "Library Communications"]

#department_names.each do |name|
#Department.create(name: name)
#end

# Seed Departments
#Create Departments
#Here, first we create an array of hashes departments to create the Department objects. Then we create an array of hashes employees to create the Employee objects, where we find the corresponding department object using Department.find_by(name: "...") and pass it to the department attribute.
require 'csv'

# Import data from employees.csv
#CSV.foreach('/Users/lisa/uclibs/staff-directory-23/db/employees.csv', headers: true) do |row|
  #Employee.create!(
   # lastname: row['lastname'],
    #   firstname: row['firstname'],
    
    #email: row['email'],
     #  phone: row['phone'],
      # title: row['title'],
    #department: row['department']

  #)
#end -->

# Import data from departments.csv
# Import data from departments.csv
require 'csv'
# Clear existing data
#Department.destroy_all
#Employee.destroy_all

# Seed departments
require 'csv'

# Seed departments
CSV.foreach('/Users/Lisa/uclibs/staff-directory-23/db/departments.csv', headers: true) do |row|
  Department.create(name: row['name'])
end

# Seed employees
CSV.foreach('/Users/Lisa/uclibs/staff-directory-23/db/employees.csv', headers: true) do |row|
  dept = Department.find_by(id: row['department_id'])
  Employee.create(
    lastname: row['lastname'],
    firstname: row['firstname'],
    email: row['email'],
    phone: row['phone'],
    title: row['title'],
    working_title: row['working_title'],
    department: dept
  )
end
