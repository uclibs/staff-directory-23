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

departments = [
  { name: 'CEAS' },
  { name: 'Administration' },
  { name: 'CCM' },
  { name: 'Application Development' },
  { name: 'Library IT' },
  { name: 'Classics' },
  { name: 'HR' },
  { name: 'Library Communications' }
]

Department.create(departments)

# Add Employees
employees = [
  { lastname: 'Haitz', firstname: 'Lisa', email: 'lisa.haitz@uc.edu', phone: '556-1431', title: 'Software Developer 2',
    department_id: Department.find_by(name: 'Application Development').id },
  { lastname: 'Hart', firstname: 'Olga', email: 'olga.hart@uc.edu', phone: '556-1850',
    title: 'Associate Senior Librarian', department_id: Department.find_by(name: 'Administration').id },
  { lastname: 'Norris', firstname: 'Melissa', email: 'melissa.norris@uc.edu', phone: '556-1558',
    title: 'Directory of Library Communication', department_id: Department.find_by(name: 'Library Communications').id },
  { lastname: 'Baldwin', firstname: 'Ted', email: 'michael.braunlin@uc.edu', phone: '556-4211',
    title: 'Associate Senior Librarian', department_id: Department.find_by(name: 'CEAS').id },
  { lastname: 'Braunlin', firstname: 'Michael', email: 'lisa.haitz@uc.edu', phone: '556-1333',
    title: 'Assistant Head Circulation', department_id: Department.find_by(name: 'Classics').id },
  { lastname: 'Chang', firstname: 'May', email: 'may.chang@uc.edu', phone: '556-3165',
    title: 'Chief Technology Officer', department_id: Department.find_by(name: 'Library IT').id }
]

Employee.create(employees)
