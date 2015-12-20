# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(firstname: 'Phil', lastname: 'Battos', email: 'philbattos@gmail.com', phone: '234-567-8901')
User.create(firstname: 'Laura', lastname: '', email: 'test@email.com', phone: '234-567-8901')
User.create(firstname: 'John', lastname: 'Doe', email: 'john@fake.com', phone: '345-678-9012')

phil = User.find_by(email: 'philbattos@gmail.com')
laura = User.find_by(email: 'test@email.com')
john = User.find_by(email: 'john@fake.com')

Transaction.create(user_id: phil.id, peer_id: laura.id, terms: '5%', amount: 20.00)
Transaction.create(user_id: laura.id, peer_id: john.id, terms: '15%', amount: 100.00)
Transaction.create(user_id: john.id, peer_id: phil.id, terms: '2%', amount: 35.25)