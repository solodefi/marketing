# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Initialize Admin User for Admin Panel
AdminUser.create!(email: 'admin@sthinking.com', password: 'password', password_confirmation: 'password')

# Initialize Profession Structural Engineers and sub categories
p_structural_engineers = Profession.create!(title: 'Structural Engineers')
Category.create!(title: 'Loft conversion', profession_id: p_structural_engineers.id)
Category.create!(title: 'Knock through', profession_id: p_structural_engineers.id)
Category.create!(title: 'Extension/New build', profession_id: p_structural_engineers.id)
Category.create!(title: 'Structural survey/Inspection', profession_id: p_structural_engineers.id)
Category.create!(title: 'Basement conversion', profession_id: p_structural_engineers.id)
Category.create!(title: 'Underpinning/Subsidence', profession_id: p_structural_engineers.id)
Category.create!(title: 'Borehole/Ground investigation', profession_id: p_structural_engineers.id)
Category.create!(title: 'Drawing/Computer modelling', profession_id: p_structural_engineers.id)
Category.create!(title: 'Building control services', profession_id: p_structural_engineers.id)
Category.create!(title: 'Other', profession_id: p_structural_engineers.id)

# Initialize Profession Surveyors and sub categories
p_surveyors = Profession.create!(title: 'Surveyors')
Category.create!(title: 'Valuation/Home buyers report', profession_id: p_surveyors.id)
Category.create!(title: 'Insurance claim/Damage survey', profession_id: p_surveyors.id)
Category.create!(title: 'Party wall survey', profession_id: p_surveyors.id)
Category.create!(title: 'Lease extension/enfranchisement', profession_id: p_surveyors.id)
Category.create!(title: 'Other', profession_id: p_surveyors.id)

# Initialize Profession Architects and Designers and sub categories
p_architects_and_designers = Profession.create!(title: 'Architects and Designers')
Category.create!(title: 'Drawing/Computer modelling', profession_id: p_architects_and_designers.id)
Category.create!(title: 'Planning application', profession_id: p_architects_and_designers.id)
Category.create!(title: 'Extension/New build', profession_id: p_architects_and_designers.id)
Category.create!(title: 'Interior design', profession_id: p_architects_and_designers.id)
Category.create!(title: 'Landscape design', profession_id: p_architects_and_designers.id)
Category.create!(title: 'Photography', profession_id: p_architects_and_designers.id)
Category.create!(title: 'Other', profession_id: p_architects_and_designers.id)

# Initialize Profession Don't know and sub categories
p_dont_know = Profession.create!(title: "Don't know")