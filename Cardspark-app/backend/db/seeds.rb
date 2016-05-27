# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Topic.create(name: 'Germany')
Topic.create(name: 'France')
Topic.create(name: 'Belgium')
Topic.create(name: 'Netherlands')
User.create(email: 'Netherlands', password_hash: 'jdje')