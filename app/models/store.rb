class Store
  def initialize(session)
    @session = session
  end

  def sign_up_candidate(body)
    ApiClient.sign_up_teacher_training_adviser_candidate(body)
  end

  def filter_returner_candidate
    data = session[:registration].select{ |key,_| Candidate::RETURNER.include? key.to_sym }
    # set default as secondary
    data.merge!({"preferred_education_phase_id"=>StageInterestedTeaching::OPTIONS[:secondary].to_i})
    data.transform_keys { |k| k.camelize(:lower).to_sym }.to_json
  end

  def candidate_info
    x = @session[:registration]
    body = {
      "candidate_id" => x["candidate_id"],
      "qualification_id" => x["qualification_id"], # not set
      "subject_taught_id" => x["subject_taught_id"],
      "past_teaching_position_id" => x["past_teaching_position_id"], # not set
      "preferred_teaching_subject_id" => x["preferred_teaching_subject_id"],
      "country_id" => x["country_id"],
      "accepted_policy_id" => x["accepted_policy_id"].to_s,
      "uk_degree_grade_id" => x["uk_degree_grade_id"],
      "degree_status_id" => x["degree_status_id"],
      "degree_type_id" => x["degree_type_id"],
      "intital_teacher_training_year_id" => x["intital_teacher_training_year_id"],
      "preferred_education_phase_id" => x["preferred_education_phase_id"],
      "has_gcse_maths_and_english_id" => x["has_gcse_maths_and_english_id"],
      "has_gcse_science_id" => x["has_gcse_science_id"],
      "planning_to_retake_gcse_maths_and_english_id" => x["planning_to_retake_gcse_maths_and_english_id"],
      "planning_to_retake_gcse_science_id" => x["planning_to_retake_gcse_science_id"],
      "email" => x["email"],
      "first_name" => x["first_name"],
      "last_name" => x["last_name"],
      "date_of_birth" => x["date_of_birth"], # DateTime
      "teacher_id" => x["teacher_id"],
      "degree_subject" => x["degree_subject"],
      "telephone" => x["telephone"],
      "address_line1" => x["address_line1"],
      "address_line2" => x["address_line2"],
      "address_city" => x["address_city"],
      "address_postcode" => x["address_postcode"],
      "phone_call_scheduled_at" => x["phone_call_scheduled_at"], # DateTime check this
      "already_subscribed_to_teacher_training_adviser" => x["subscribed"], # Boolean
    }
    body.transform_keys { |k| k.camelize(:lower).to_sym }.to_json
  end
end
