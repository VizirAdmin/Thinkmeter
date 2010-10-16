# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ithink_session',
  :secret      => '7c88d48794cbbb2e9ae724a0fbd34bd58f98a5e8c1907faa38318153b29657d9ede7ea7ea145d35d6fca681e914b4b38df987fe6e9af1bd75a7993214c2324c3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
