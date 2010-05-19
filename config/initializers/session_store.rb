# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_finance_session',
  :secret      => 'b1d39526ab8e98cf7af487c4c1c48ba0fef8b25cd3f863e95c89960d500d5c00ba514c90be508788b4e44ed022f77a40f3e47d5583dbd86d4e011c00255afb03'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
