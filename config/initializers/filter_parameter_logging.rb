# Be sure to restart your server when you modify this file.

# Configure parameters to be filtered from the log file. Use this to limit dissemination of
# sensitive information. See the ActiveSupport::ParameterFilter documentation for supported
# notations and behaviors.
Rails.application.config.filter_parameters += %i[
  address_city
  address_line1
  address_line2
  address_postcode
  date_of_birth
  email
  first_name
  last_name
  password
  teacher_id
  telephone
  address_telephone
  timed_one_time_password
]
