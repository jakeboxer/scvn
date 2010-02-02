# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_scvn_session',
  :secret      => 'c68bc434a5781af29545f92f1c03e1fae8836f37e181ee81bd5d9059cc05624c65fd3a0bb19846cdd453d44465ce1201e1f484c20e44de9b402ed6ab3df4969a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
