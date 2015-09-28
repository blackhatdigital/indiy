# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: "admin", password: "password", publishable_key: "pk_test_hDN0uNbAFxQ5LDzi9jypvZCJ", stripe_user_id: "acct_16nOEmIDysV1eWIb", secret_key: "sk_test_gzIJgC8zxpsvpIRCbqNHIM12")