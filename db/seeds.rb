# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Clear the database (do not clear Users - they are managed separately)
Employee.delete_all
Department.delete_all

departments = [
  { name: 'Reference, Teaching and Services' },
  { name: 'UCL Collection Development Services and Engagement' },
  { name: 'UCL Health Sciences Library' },
  { name: 'Administration' },
  { name: 'UCL Content Services' },
  { name: 'UCL Science and Engineering Libraries' },
  { name: 'CCM Library' },
  { name: 'Classics Library' },
  { name: 'Preservation Services' },
  { name: 'CECH Library' },
  { name: 'Business Office' },
  { name: 'UCL Research and Data Services' },
  { name: 'Archives and Rare Books Library' },
  { name: 'Human Resources' },
  { name: 'DAAP Library' },
  { name: 'UC Press' },
  { name: 'Library Communications' },
  { name: 'Library IT' },
  { name: 'UCL Application Development' }
]

Department.create(departments)

# Add Employees (matches libappstest data)
employees = [
  { lastname: 'Alfieri', firstname: 'Michael', email: 'michael.alfieri@uc.edu', phone: '556-1852', title: 'Director, User Services', department_id: Department.find_by(name: 'Reference, Teaching and Services').id },
  { lastname: 'Anderson', firstname: 'Meshia', email: 'meshia.anderson@uc.edu', phone: '556-6596', title: 'Interlibrary Loan Specialist', department_id: Department.find_by(name: 'UCL Collection Development Services and Engagement').id },
  { lastname: 'Bachelder', firstname: 'Dean', email: 'dean.bachelder@uc.edu', phone: '558-5677', title: 'Evening and Weekend Supervisor, Circulation Desk', department_id: Department.find_by(name: 'UCL Health Sciences Library').id },
  { lastname: 'Baldwin', firstname: 'Ted', email: 'ted.baldwin@uc.edu', phone: '556-4211', title: 'Interim Head, Collections; Dir Science Engineer Li', department_id: Department.find_by(name: 'Administration').id },
  { lastname: 'Banoun', firstname: 'Susan', email: 'susan.banoun@uc.edu', phone: '556-1440', title: 'Team Leader, eResources & Access', department_id: Department.find_by(name: 'UCL Content Services').id },
  { lastname: 'Becker', firstname: 'Alan', email: 'beckeraj@ucmail.uc.edu', phone: '556-2650', title: 'Public Services Assistant', department_id: Department.find_by(name: 'Reference, Teaching and Services').id },
  { lastname: 'Bernardo', firstname: 'Christa', email: 'bernarct@foundation.uc.edu', phone: '556-0055', title: 'Director of Development', department_id: Department.find_by(name: 'Administration').id },
  { lastname: 'Bettencourt-McCarthy', firstname: 'Aja', email: 'bettenar@ucmail.uc.edu', phone: '556-5707', title: 'Science-Engineering Global Services Librarian', department_id: Department.find_by(name: 'UCL Science and Engineering Libraries').id },
  { lastname: 'Bhat', firstname: 'Nimisha', email: 'nimisha.bhat@uc.edu', phone: '556-4657', title: 'History, WGSS & Anthropology Librarian', department_id: Department.find_by(name: 'Reference, Teaching and Services').id },
  { lastname: 'Bourne', firstname: 'Regina', email: 'regina.bourne@uc.edu', phone: '556-0326', title: 'Director, Inclusion, Diversity & Org Development', department_id: Department.find_by(name: 'Administration').id },
  { lastname: 'Bratt', firstname: 'Suzanne', email: 'brattse@ucmail.uc.edu', phone: '556-1963', title: 'CCM Library Cataloging Librarian', department_id: Department.find_by(name: 'CCM Library').id },
  { lastname: 'Braunlin', firstname: 'Michael', email: 'michael.braunlin@uc.edu', phone: '556-1333', title: 'Assistant Head Classics Library', department_id: Department.find_by(name: 'Classics Library').id },
  { lastname: 'Campbell', firstname: 'James', email: 'James.Campbell@uc.edu', phone: '556-1408', title: 'Network Analyst', department_id: Department.find_by(name: 'Library IT').id },
  { lastname: 'Chalmers', firstname: 'Mark', email: 'chalmemk@ucmail.uc.edu', phone: '556-1452', title: 'Science & Engineering Librarian', department_id: Department.find_by(name: 'UCL Science and Engineering Libraries').id },
  { lastname: 'Chang', firstname: 'May', email: 'may.chang@uc.edu', phone: '556-3165', title: 'Library Chief Technology Officer', department_id: Department.find_by(name: 'Library IT').id },
  { lastname: 'Corday', firstname: 'Mikaila', email: 'mikaila.corday@uc.edu', phone: '556-1013', title: 'eResources & Access', department_id: Department.find_by(name: 'UCL Content Services').id },
  { lastname: 'Crowe', firstname: 'Sean', email: 'sean.crowe@uc.edu', phone: '556-1899', title: 'Digital Analyst and Developer Librarian', department_id: Department.find_by(name: 'UCL Application Development').id },
  { lastname: 'Doctor', firstname: 'Jenny', email: 'jenny.doctor@uc.edu', phone: '556-1964', title: 'Head of the Albino Gorno Memorial (CCM) Library', department_id: Department.find_by(name: 'CCM Library').id },
  { lastname: 'Ebert', firstname: 'Jessica', email: 'jessica.ebert@uc.edu', phone: '556-1877', title: 'Conservation Technician', department_id: Department.find_by(name: 'Preservation Services').id },
  { lastname: 'Ferguson Schieszer', firstname: 'Ashleigh', email: 'ashleigh.schieszer@uc.edu', phone: '556-4289', title: 'Lab Conservator', department_id: Department.find_by(name: 'Preservation Services').id },
  { lastname: 'Figueirinhas', firstname: 'Catarina', email: 'catarina.figueirinhas@uc.edu', phone: '556-4280', title: 'Sr. Conservation Specialist', department_id: Department.find_by(name: 'Preservation Services').id },
  { lastname: 'Foran-Mulcahy', firstname: 'Katie', email: 'foranmkn@ucmail.uc.edu', phone: '556-1758', title: 'Head, CECH Library', department_id: Department.find_by(name: 'CECH Library').id },
  { lastname: 'Gaiser', firstname: 'Madeleine', email: 'gaiserml@ucmail.uc.edu', phone: '556-1430', title: 'Online Learning & Instruction Librarian', department_id: Department.find_by(name: 'CECH Library').id },
  { lastname: 'Gao', firstname: 'Sidney', email: 'gaosy@ucmail.uc.edu', phone: '556-4696', title: 'Digital Collections Manager', department_id: Department.find_by(name: 'UCL Content Services').id },
  { lastname: 'Gichuru', firstname: 'Dorcas', email: 'gichurds@ucmail.uc.edu', phone: '556-1463', title: 'Business Manager', department_id: Department.find_by(name: 'Business Office').id },
  { lastname: 'Grant', firstname: 'Tiffany', email: 'tiffany.grant@uc.edu', phone: '558-9153', title: 'Assistant Director for Research and Informatics', department_id: Department.find_by(name: 'UCL Research and Data Services').id },
  { lastname: 'Grigg Dean', firstname: 'Elaine', email: 'griggdeh@ucmail.uc.edu', phone: '556-1550', title: 'Information Specialist', department_id: Department.find_by(name: 'UCL Science and Engineering Libraries').id },
  { lastname: 'Harris', firstname: 'Lori', email: 'lori.harris@uc.edu', phone: '558-0315', title: 'Interim Assoc Dean Public Services', department_id: Department.find_by(name: 'Administration').id },
  { lastname: 'Hart', firstname: 'Olga', email: 'olga.hart@uc.edu', phone: '556-1850', title: 'Coordinator of Library Instruction', department_id: Department.find_by(name: 'Reference, Teaching and Services').id },
  { lastname: 'Harter', firstname: 'Christopher', email: 'hartercr@ucmail.uc.edu', phone: '556-1959', title: 'University Archivist and Head, ARB Library', department_id: Department.find_by(name: 'Archives and Rare Books Library').id },
  { lastname: 'Hershiser', firstname: 'Madison', email: 'hershime@ucmail.uc.edu', phone: '556-1454', title: 'Resource Sharing Assistant', department_id: Department.find_by(name: 'UCL Collection Development Services and Engagement').id },
  { lastname: 'Hight', firstname: 'Susan', email: 'susan.hight@uc.edu', phone: '556-3230', title: 'Technical & Public Services Assistant', department_id: Department.find_by(name: 'UCL Science and Engineering Libraries').id },
  { lastname: 'Hiller', firstname: 'Karl', email: 'karl.hiller@uc.edu', phone: '556-6203', title: 'IT Analyst', department_id: Department.find_by(name: 'Library IT').id },
  { lastname: 'Hoople', firstname: 'Rachel', email: 'hooplere@ucmail.uc.edu', phone: '556-1307', title: 'Operations Manager and Student Supervisor', department_id: Department.find_by(name: 'CECH Library').id },
  { lastname: 'Horton', firstname: 'Glen', email: 'glen.horton@uc.edu', phone: '556-1491', title: 'Head, Application Development Unit', department_id: Department.find_by(name: 'UCL Application Development').id },
  { lastname: 'Huyck', firstname: 'Janell', email: 'janell.huyck@uc.edu', phone: '556-0633', title: 'Software Developer', department_id: Department.find_by(name: 'UCL Application Development').id },
  { lastname: 'Hyden', firstname: 'Amanda', email: 'amanda.hyden@uc.edu', phone: '556-1042', title: 'eResources & Access', department_id: Department.find_by(name: 'UCL Content Services').id },
  { lastname: 'IT@Langsam', firstname: 'IT@Langsam', email: 'it-langsam@uc.edu', phone: '556-0168', title: 'Technology Assistance', department_id: Department.find_by(name: 'Library IT').id },
  { lastname: 'Jackson', firstname: 'Angela', email: 'angela.jackson@uc.edu', phone: '556-1515', title: 'Associate To', department_id: Department.find_by(name: 'Administration').id },
  { lastname: 'Jason', firstname: 'Don', email: 'don.jason@uc.edu', phone: '558-0725', title: 'Clinical Informationist', department_id: Department.find_by(name: 'UCL Research and Data Services').id },
  { lastname: 'Johnson', firstname: 'Arlene', email: 'arlene.johnson@uc.edu', phone: '556-1417', title: 'Head, Collection Development Services & Engagement', department_id: Department.find_by(name: 'UCL Collection Development Services and Engagement').id },
  { lastname: 'Johnson', firstname: 'Meni', email: 'jomk@ucmail.uc.edu', phone: '5563086', title: 'Sr. HR. Coordinator', department_id: Department.find_by(name: 'Human Resources').id },
  { lastname: 'Johnson', firstname: 'Marcia', email: 'john5md@ucmail.uc.edu', phone: '558-0381', title: 'Library Services Supervisor', department_id: Department.find_by(name: 'UCL Science and Engineering Libraries').id },
  { lastname: 'Kiscaden', firstname: 'Elizabeth', email: 'kiscadeh@ucmail.uc.edu', phone: '556-1515', title: 'Dean and University Librarian', department_id: Department.find_by(name: 'Administration').id },
  { lastname: 'Kline', firstname: 'Ben', email: 'ben.kline@uc.edu', phone: '556-1419', title: 'Assistant Department Head, RTS', department_id: Department.find_by(name: 'Reference, Teaching and Services').id },
  { lastname: 'Koshoffer', firstname: 'Amy', email: 'amy.koshoffer@uc.edu', phone: '556-1310', title: 'Asst Director, Research & Data Services', department_id: Department.find_by(name: 'UCL Research and Data Services').id },
  { lastname: 'Lindau', firstname: 'Rebecka', email: 'rebecka.lindau@uc.edu', phone: '556-1316', title: 'Head of the John Miller Burnam Classical Library', department_id: Department.find_by(name: 'Classics Library').id },
  { lastname: 'Mackiewicz', firstname: 'Jenny', email: 'jennifer.mackiewicz@uc.edu', phone: '556-1394', title: 'Coordinator of Special Projects and Programs', department_id: Department.find_by(name: 'Administration').id },
  { lastname: 'Mao', firstname: 'Yu', email: 'maoyu@ucmail.uc.edu', phone: '556-1551', title: 'Director of Business Affairs', department_id: Department.find_by(name: 'Business Office').id },
  { lastname: 'Meyer', firstname: 'Elizabeth', email: 'elizabeth.meyer@uc.edu', phone: '556-0279', title: 'Visual Resources Librarian', department_id: Department.find_by(name: 'DAAP Library').id },
  { lastname: 'Mihaly', firstname: 'Sara', email: 'sara.mihaly@uc.edu', phone: '556-1365', title: 'Student Supervisor& Collections Receiving Speciali', department_id: Department.find_by(name: 'UCL Content Services').id },
  { lastname: 'Minelli', firstname: 'Mark', email: 'minellmr@ucmail.uc.edu', phone: '556-6276', title: 'Journals & Digital Production Manager', department_id: Department.find_by(name: 'UC Press').id },
  { lastname: 'Moena', firstname: 'Diego', email: 'moenads@ucmail.uc.edu', phone: '556-1411', title: 'Collections Acquisitions', department_id: Department.find_by(name: 'UCL Content Services').id },
  { lastname: 'Mudd', firstname: 'Matthew', email: 'muddmw@ucmail.uc.edu', phone: '558-0127', title: 'Endpoint Specialist', department_id: Department.find_by(name: 'UCL Health Sciences Library').id },
  { lastname: 'Norris', firstname: 'Melissa', email: 'melissa.norris@uc.edu', phone: '556-1558', title: 'Director of Library Communications', department_id: Department.find_by(name: 'Library Communications').id },
  { lastname: 'Patel', firstname: 'Margaux', email: 'margaux.patel@uc.edu', phone: '556-1580', title: 'Business & Data Analytic Librarian', department_id: Department.find_by(name: 'Reference, Teaching and Services').id },
  { lastname: 'Person', firstname: 'Craig', email: 'personcg@ucmail.uc.edu', phone: '556-1453', title: 'Associate Director of Operations', department_id: Department.find_by(name: 'UCL Science and Engineering Libraries').id },
  { lastname: 'Pons', firstname: 'test2', email: 'lisa3711@yahoo.com', phone: '1234567890', title: 'king', department_id: Department.find_by(name: 'UCL Content Services').id },
  { lastname: 'Previtera', firstname: 'Melissa', email: 'melissa.previtera@uc.edu', phone: '558-3071', title: 'Academic & Research Services Specialist', department_id: Department.find_by(name: 'UCL Health Sciences Library').id },
  { lastname: 'Prochaska', firstname: 'Holly', email: 'holly.prochaska@uc.edu', phone: '556-1389', title: 'Head, Preservation Services', department_id: Department.find_by(name: 'Preservation Services').id },
  { lastname: 'Purtee', firstname: 'Sharon', email: 'sharon.purtee@uc.edu', phone: '558-1019', title: 'Interim Head, Health Sciences Library', department_id: Department.find_by(name: 'UCL Health Sciences Library').id },
  { lastname: 'Reder', firstname: 'Lauren', email: 'rederle@ucmail.uc.edu', phone: '000.0000', title: 'Cataloguer, Classics/Modern Greek', department_id: Department.find_by(name: 'UCL Content Services').id },
  { lastname: 'Reller', firstname: 'Suzanne', email: 'suzanne.reller@uc.edu', phone: '556-7016', title: 'Reference/Collections Librarian', department_id: Department.find_by(name: 'Archives and Rare Books Library').id },
  { lastname: 'Richardson', firstname: 'Andrew', email: 'richaa3@ucmail.uc.edu', phone: '558-0127', title: 'Computer & Information Analyst', department_id: Department.find_by(name: 'UCL Health Sciences Library').id },
  { lastname: 'Rinto', firstname: 'Erin', email: 'rintoen@ucmail.uc.edu', phone: '000.0000', title: 'Learning and Research Librarian', department_id: Department.find_by(name: 'Reference, Teaching and Services').id },
  { lastname: 'Sandor', firstname: 'David', email: 'david.sandor@uc.edu', phone: '556-1510', title: 'Circulation Supervisor', department_id: Department.find_by(name: 'CCM Library').id },
  { lastname: 'Scarpelli', firstname: 'Elizabeth', email: 'scarpeea@ucmail.uc.edu', phone: '556-1494', title: 'Director UC Press', department_id: Department.find_by(name: 'UC Press').id },
  { lastname: 'Scherz', firstname: 'Thomas', email: 'thomas.scherz@uc.edu', phone: '556-1406', title: 'Senior Software Developer', department_id: Department.find_by(name: 'UCL Application Development').id },
  { lastname: 'Schnee', firstname: 'Samantha', email: 'samantha.schaffer@uc.edu', phone: '556-1404', title: 'System Administrator', department_id: Department.find_by(name: 'Library IT').id },
  { lastname: 'Sliney', firstname: 'Kyle', email: 'slineykm@ucmail.uc.edu', phone: '558-0430', title: 'Multimedia Designer', department_id: Department.find_by(name: 'UCL Health Sciences Library').id },
  { lastname: 'Smith', firstname: 'Erin', email: 'smith8en@ucmail.uc.edu', phone: '556-1560', title: 'Collections Acquisitions Specialist', department_id: Department.find_by(name: 'UCL Content Services').id },
  { lastname: 'Snyder', firstname: 'Edward', email: 'snyderew@ucmail.uc.edu', phone: '556-0168', title: 'Endpoint Specialist', department_id: Department.find_by(name: 'Library IT').id },
  { lastname: 'Sorrell', firstname: 'Scott', email: 'sorrelsc@ucmail.uc.edu', phone: '558-0290', title: 'Computer Systems Administrator - Lead', department_id: Department.find_by(name: 'Library IT').id },
  { lastname: 'Stevens', firstname: 'Cade', email: 'cade.stevens@uc.edu', phone: '556-1321', title: 'Student & Circulation Supervisor', department_id: Department.find_by(name: 'DAAP Library').id },
  { lastname: 'Stewart', firstname: 'Shannan', email: 'stewars3@ucmail.uc.edu', phone: '556-1314', title: 'Library Specialist', department_id: Department.find_by(name: 'Classics Library').id },
  { lastname: 'Stork', firstname: 'John', email: 'john.stork@uc.edu', phone: '556-1984', title: 'Assistant Head, Collection Development Svcs', department_id: Department.find_by(name: 'UCL Collection Development Services and Engagement').id },
  { lastname: 'Taylor-Slaughter', firstname: 'June', email: 'june.taylor@uc.edu', phone: '556-1587', title: 'Research & Services Specialist', department_id: Department.find_by(name: 'UCL Science and Engineering Libraries').id },
  { lastname: 'Temple', firstname: 'Alex', email: 'templea@ucmail.uc.edu', phone: '556-1959', title: 'Archivist', department_id: Department.find_by(name: 'Archives and Rare Books Library').id },
  { lastname: 'Tenofsky', firstname: 'Deborah', email: 'deborah.tenofsky@uc.edu', phone: '556-1888', title: 'Head of Research, Teaching, and Services', department_id: Department.find_by(name: 'Reference, Teaching and Services').id },
  { lastname: 'Test', firstname: 'Sally', email: 'test@uc.edu', phone: '513-555-1212', title: 'Anonymous Employee', department_id: Department.find_by(name: 'Administration').id },
  { lastname: 'Thatcher', firstname: 'Carissa', email: 'carissa.thatcher@uc.edu', phone: '556-5758', title: 'Team Leader, Collections Acquisitions', department_id: Department.find_by(name: 'UCL Content Services').id },
  { lastname: 'Tucker', firstname: 'Hyacinth', email: 'hyacinth.tucker@uc.edu', phone: '556-1880', title: 'Binding Processor', department_id: Department.find_by(name: 'Preservation Services').id },
  { lastname: 'Van Mil', firstname: 'James', email: 'James.VanMil@uc.edu', phone: '556-1410', title: 'Digital Projects & Preservation Librarian', department_id: Department.find_by(name: 'UCL Content Services').id },
  { lastname: 'Wagner', firstname: 'Gerald', email: 'gerald.wagner@uc.edu', phone: '558-8389', title: 'Manager, Unit Operations', department_id: Department.find_by(name: 'UCL Collection Development Services and Engagement').id },
  { lastname: 'Warner', firstname: 'Lynn', email: 'warnerlc@ucmail.uc.edu', phone: '558-4173', title: 'Research & Health Sciences Librarian', department_id: Department.find_by(name: 'UCL Health Sciences Library').id },
  { lastname: 'Welter', firstname: 'Amanda', email: 'amanda.welter@uc.edu', phone: '556-7015', title: 'Director, Library Facilities and Planning', department_id: Department.find_by(name: 'Administration').id },
  { lastname: 'werewr', firstname: 'werewr', email: 'wwere@gmail.com', phone: '12313124', title: 'dfgdsfsfsdfsf', department_id: Department.find_by(name: 'UCL Application Development').id },
  { lastname: 'Williams', firstname: 'Sara', email: 'sara.williams3@uc.edu', phone: '556-1396', title: 'Collections Acquisitions', department_id: Department.find_by(name: 'UCL Content Services').id },
  { lastname: 'Wissman', firstname: 'Pamela', email: 'seyrinpa@ucmail.uc.edu', phone: '556-6386', title: 'Editorial, Design, and Production Manager', department_id: Department.find_by(name: 'UC Press').id },
  { lastname: 'Wysinski', firstname: 'Nathan', email: 'wysinsnj@ucmail.uc.edu', phone: '558-4073', title: 'IT Manager', department_id: Department.find_by(name: 'UCL Health Sciences Library').id },
  { lastname: 'Zonker', firstname: 'Christopher', email: 'zonkerca@ucmail.uc.edu', phone: '556-1996', title: 'Financial Administrator 2', department_id: Department.find_by(name: 'Business Office').id }
]

Employee.create(employees)

# Test-server-only login: create test@example.com only when running on libappstest.
# Safe to run full db:seed on production (libapps) — this user will not be created there.
require Rails.root.join('lib', 'seed_helper')
SeedHelper.seed_test_user! if SeedHelper.test_server?