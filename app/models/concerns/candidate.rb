module Candidate
  RETURNER = %i[
    first_name
    last_name
    date_of_birth
    address_line1
    address_line2
    address_city
    address_postcode
    email
    telephone
    teacher_id
    subject_taught_id
    preferred_teaching_subject_id
    country_id
    accepted_policy_id
    preferred_education_phase_id
    accepted_policy_id
  ].freeze

  DEGREE = %i[
    first_name
    last_name
    email
    degree_status_id
    degree_type_id
    degree_subject
    uk_degree_grade_id
    preferred_education_phase_id
    has_gcse_maths_and_english_id
    planning_to_retake_gcse_maths_and_english_id
    has_gcse_science_id
    planning_to_retake_gcse_science_id
    initial_teacher_training_year_id
    date_of_birth
    country_id
    address_line1
    address_line2
    address_city
    address_postcode
    telephone
    accepted_policy_id
    preferred_teaching_subject_id
  ].freeze

  STUDYING = DEGREE

  EQUIVALENT = %i[
    first_name
    last_name
    email
    degree_status_id
    degree_type_id
    preferred_education_phase_id
    preferred_teaching_subject_id
    initial_teacher_training_year_id
    date_of_birth
    country_id
    address_line1
    address_line2
    address_city
    address_postcode
    telephone
    phone_call_scheduled_at
    accepted_policy_id
  ].freeze
end
