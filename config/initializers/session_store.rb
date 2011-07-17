# Be sure to restart your server when you modify this file.

Naply::Application.config.session_store :cookie_store, :key => '_naply_session'

ActionController::Base.session = {
  :key         => '_tropo_session',
  :secret      => '061de1e89300434d81b7cfa2acf8dc0447576a1ba2e95de3bfff637f4d16a860c932b0c5c8415bd390f21b3a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Naply::Application.config.session_store :active_record_store
