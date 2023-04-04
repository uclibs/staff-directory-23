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




1.times do |i|
Department.create(name: "CEAS")
Department.create(name: "Administration")
Department.create(name: "CCM")
Department.create(name: "Application Development")
Department.create(name: "Library IT")
Department.create(name: "Classics")
Department.create(name: "HR")
Department.create(name: "Library Communications")
end
 #Add Employees

1.times do |i|
Employee.create(lastname: "Haitz", firstname:"Lisa",email: "lisa.haitz@uc.edu", phone:"556-1431",title: "Software Developer 2", department: "Application Development")
Employee.create(lastname: "Hart", firstname:"Olga",email: "olga.hart@uc.edu", phone:"556-1850",title: "Associate Senior Librarian", department: "Administration")
Employee.create(lastname: "Norris", firstname:"Melissa ",email: "melissa.norris@uc.edu", phone:"556-1558",title: "Directory of Library Communication", department: "Library Communication")
Employee.create(lastname: "Baldwin", firstname:"Ted",email: "michael.braunlin@uc.edu", phone:"556-4211",title: "Associate Senior Librarian", department: "CEAS")
Employee.create(lastname: "Braunlin", firstname:"Michael",email: "lisa.haitz@uc.edu", phone:"556-1333",title: "Assistant Head Circulation", department: "Classics")
Employee.create(lastname: "Chang", firstname:"May",email: "may.chang@uc.edu", phone:"556-3165",title: "Chief Technology Office", department: "Library IT")
end