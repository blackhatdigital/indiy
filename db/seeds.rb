# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(username: "admin", password: "password", email: "test@example.com", publishable_key: "pk_test_hDN0uNbAFxQ5LDzi9jypvZCJ", stripe_user_id: "acct_16nOEmIDysV1eWIb", secret_key: "sk_test_gzIJgC8zxpsvpIRCbqNHIM12")
product = Product.create(user: user, name: "Example Product", price: 1000,short_description: "Breif summary of product right bellow the title and price", long_description: "No folks we’re not pulling you leg! This rare Chinese tea is carefully picked by specially trained monkeys in a remote mountain region of China. Legend has it that monkeys were first used to collect tea ten centuries ago, because upon seeing it’s master trying to reach some tea growing wild on a mountain face, the monkey climbed up the steep face and collected the tea growing there and brought it down to his master. This wild tea was considered so delicious that other people began to train monkeys to collect this rare wild tea. Nowadays the practice of monkeys picking tea has all but died out, except in one small remote village where they still continue this remarkable tradition. No monkeys are harmed or mistreated in order for us to bring this rare brew to you! In fact the monkeys and their ancestors before them have been doing this job for generations and are treated as respected members of their human keeper’s families.", remote_product_image_url: "http://teametiny.com/wp-content/uploads/2014/12/monkey-tea-2.jpg", remote_product_file_url: "http://cdn2.business2community.com/wp-content/uploads/2014/09/product-600x290.jpg")
Payment.create(product: product, name: "Steve", email: "steve@example.com", price: 1000, receipt: "rfklsfnlsie2", created_at: 2.days.ago.to_date)
Payment.create(product: product, name: "Bob", email: "bob@example.com", price: 1000, receipt: "faslfn323e2nwkls", created_at: 3.days.ago.to_date)
Payment.create(product: product, name: "Rohan", email: "rohan@example.com", price: 1000, receipt: "kfdnelwrr382wss", created_at: Time.now.to_date)
Payment.create(product: product, name: "Paul", email: "paul@example.com", price: 1000, receipt: "dknsefiwdskln3weklnsd", created_at: 4.weeks.ago.to_date)
Payment.create(product: product, name: "Gary", email: "gary@example.com", price: 1000, receipt: "kncsdlfncslkdf", created_at: 1.year.ago.to_date)
Payment.create(product: product, name: "Joey", email: "joey@example.com", price: 1000, receipt: "fkjbaskd3unedlkwld", created_at: 10.days.ago.to_date)
