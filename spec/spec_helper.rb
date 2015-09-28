# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'vcr'
require 'capybara/email/rspec'
require 'sidekiq/testing/inline'
OmniAuth.config.test_mode = true
omniauth_stripe_hash = {"provider" => "stripe_connect","uid" => "acct_16FzCIKvv4sqfP0N","info" => {"name" => "thomas.peter.hughes@gmail.com","email" => "thomas.peter.hughes@gmail.com","nickname" => nil,"scope" => "read_write","livemode" => false,"stripe_publishable_key" => "pk_test_pI5GJFdaKP2bp2nQlZ5Ij4BA"},"credentials" => {"token" => "sk_test_d5m8oIS5HW0qEun5Wg0eH5bq","expires" => false,"refresh_token" => "rt_712fXsBtBoCaduwYZ8mSk8v6rrSR2RTnAV6HBTKyrflhmgoa"},"extra" => {"raw_info" => {"livemode" => false,"token_type" => "bearer","stripe_publishable_key" => "pk_test_pI5GJFdaKP2bp2nQlZ5Ij4BA","stripe_user_id" => "acct_16FzCIKvv4sqfP0N","scope" => "read_write"},"extra_info" => {"id" => "acct_16FzCIKvv4sqfP0N","email" => "thomas.peter.hughes@gmail.com","statement_descriptor" => nil,"display_name" => nil,"timezone" => "Asia/Makassar","details_submitted" => false,"charges_enabled" => false,"transfers_enabled" => false,"currencies_supported" => ["usd","aed","afn","all","amd","ang","aoa","ars","aud","awg","azn","bam","bbd","bdt","bgn","bif","bmd","bnd","bob","brl","bsd","bwp","bzd","cad","cdf","chf","clp","cny","cop","crc","cve","czk","djf","dkk","dop","dzd","egp","etb","eur","fjd","fkp","gbp","gel","gip","gmd","gnf","gtq","gyd","hkd","hnl","hrk","htg","huf","idr","ils","inr","isk","jmd","jpy","kes","kgs","khr","kmf","krw","kyd","kzt","lak","lbp","lkr","lrd","lsl","ltl","mad","mdl","mga","mkd","mnt","mop","mro","mur","mvr","mwk","mxn","myr","mzn","nad","ngn","nio","nok","npr","nzd","pab","pen","pgk","php","pkr","pln","pyg","qar","ron","rsd","rub","rwf","sar","sbd","scr","sek","sgd","shp","sll","sos","srd","std","svc","szl","thb","tjs","top","try","ttd","twd","tzs","uah","ugx","uyu","uzs","vnd","vuv","wst","xaf","xcd","xof","xpf","yer","zar","zmw"],"default_currency" => "usd","country" => "US","object" => "account","business_name" => nil,"business_url" => nil,"support_phone" => nil,"business_logo" => nil,"metadata" => {},"managed" => false}}}
OmniAuth.config.add_mock(:stripe_connect, omniauth_stripe_hash)
# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
end
# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.treat_symbols_as_metadata_keys_with_true_values = true
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explictly tag your specs with their type, e.g.:
  #
  #     describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/v/3-0/docs
  config.infer_spec_type_from_file_location!
end
