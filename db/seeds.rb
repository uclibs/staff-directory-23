# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb
# alternate:
# department_names = ["CEAS", "Administration", "CCM", "Application Development", "Library IT", "Classics", "HR", "Library Communications"]

# department_names.each do |name|
# Department.create(name: name)
# end
# Clear the database
Department.delete_all
Employee.delete_all

# Create departments
departments = ['CEAS', 'Administration', 'CCM', 'Application Development', 'Library IT', 'Classics', 'HR',
               'Library Communications']
departments.each do |name|
  Department.create(name: name)
end

# Create employees
employees = [
  { lastname: 'Haitz', firstname: 'Lisa', email: 'lisa.haitz@uc.edu', phone: '556-1431', title: 'Software Developer 2',
    department: Department.find_by(name: 'Application Development') },
  { lastname: 'Hart', firstname: 'Olga', email: 'olga.hart@uc.edu', phone: '556-1850',
    title: 'Associate Senior Librarian', department: Department.find_by(name: 'Administration') },
  { lastname: 'Norris', firstname: 'Melissa', email: 'melissa.norris@uc.edu', phone: '556-1558',
    title: 'Director of Library Communication', department: Department.find_by(name: 'Library Communications') },
  { lastname: 'Baldwin', firstname: 'Ted', email: 'ted.baldwin@uc.edu', phone: '556-4211',
    title: 'Associate Senior Librarian', department: Department.find_by(name: 'CEAS') },
  { lastname: 'Braunlin', firstname: 'Michael', email: 'michael.braunlin@uc.edu', phone: '556-1333',
    title: 'Assistant Head Circulation', department: Department.find_by(name: 'Classics') },
  { lastname: 'Chang', firstname: 'May', email: 'may.chang@uc.edu', phone: '556-3165',
    title: 'Chief Technology Officer', department: Department.find_by(name: 'Library IT') }
]

employees.each do |employee|
  Employee.create(employee)
end
