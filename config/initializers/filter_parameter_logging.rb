# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
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
  timed_one_time_password
]
