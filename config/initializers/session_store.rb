# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_skeleton_session',
  :secret      => '9fcf6e5d878d84534342b67137ca32ba39b9e2a66de1762dc65a55bb5eb8d9869b2a38cb12934a6d4a7100b611d2ade77379aea949aa290a9c239a7ad43811cd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
