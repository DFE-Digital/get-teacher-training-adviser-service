class Store
  def initialize(session)
    @session = session
  end

  def candidate_info
    x = @session[:registration]
    body = {
      "candidate_id" => x["candidate_id"],
      "qualification_id" => x["qualification_id"],
      "subject_taught_id" => x["prev_subject"],
      "past_teaching_position_id" => x["past_teaching_position_id"],
      "preferred_teaching_subject" => x["like_to_teach"],
      "country_id" => x["country_code"],
      "accepted_policy" => x["accepted"].to_s,
      "uk_degree_grade_id" => x["degree_class"],
      "degree_status_id" => x["degree"],
      "degree_type_id" => x["degree_type"],
      "intital_teacher_training_year_id" => x["year_of_entry"],
      "preferred_education_phase_id" => x["primary_or_secondary"],
      "has_gcse_english_id" => x["has_required_subjects"],
      "has_gcse_maths_id" => x["has_required_subjects"],
      "has_gcse_science_id" => x["have_science"],
      "planning_to_retake_gcse_english_id" => x["retaking_english_maths"],
      "planning_to_retake_gcse_maths_id" => x["retaking_english_maths"],
      "planning_to_retake_cgse_science_id" => x["retaking_science"],
      "email" => x["email_address"],
      "first_name" => x["first_name"],
      "last_name" => x["last_name"],
      "date_of_birth" => x["date_of_birth"], # DateTime
      "teacher_id" => x["prev_id"],
      "degree_subject" => x["degree_subject"],
      "telephone" => x["telephone"],
      "address_line1" => x["address_line1"],
      "address_line2" => x["address_line2"],
      "address_city" => x["town_city"],
      "address_postcode" => x["postcode"],
      "phone_call_scheduled_at" => x["callback_slot"], # DateTime
      "already_subscribed_to_teacher_training_adviser" => x["subscribed"], # Boolean
    }
    body.transform_keys { |k| k.camelize(:lower).to_sym }.to_json
  end
end
