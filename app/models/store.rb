class Store
  def initialize(session, step_name)
    @session = session
    @step_name = step_name
  end

  def sign_up_candidate(body)
    ApiClient.sign_up_teacher_training_adviser_candidate(body)
  end

  def select_candidate
    case step_name
    when "accept_privacy_policy"
      filter_returner_candidate
    when "degree/accept_privacy_policy"
      filter_degree_candidate
    when "studying/accept_privacy_policy"
      filter_studying_candidate
    when "equivalent/bodyaccept_privacy_policy"
      filter_equivalent_candidate
    end
  end

  def filter_returner_candidate
    data = @session[:registration].select { |key, _| Candidate::RETURNER.include? key.to_sym }
    # set default as secondary
    data.merge!({ "preferred_education_phase_id" => StageInterestedTeaching::OPTIONS[:secondary].to_i })
    data.transform_keys { |k| k.camelize(:lower).to_sym }.to_json
  end

  def filter_degree_candidate
    data = @session[:registration].select { |key, _| Candidate::DEGREE.include? key.to_sym }
    merge_integers(data)
  end

  def filter_studying_candidate
    data = @session[:registration].select { |key, _| Candidate::STUDYING.include? key.to_sym }
    merge_integers(data)
  end

  def filter_equivalent_candidate
    data = @session[:registration].select { |key, _| Candidate::EQUIVALENT.include? key.to_sym }
    merge_integers(data)
  end

  def merge_integers(body)
    str_values = %w[
      uk_degree_grade_id
      degree_status_id
      degree_type_id
      initial_teacher_training_year_id
      preferred_education_phase_id
      has_gcse_maths_and_english_id
      has_gcse_science_id
      planning_to_retake_gcse_maths_and_english_id
      planning_to_retake_gcse_science_id
    ]
    str_values.each do |str|
      body.merge!({ str => body[str].to_i }) if body.key?(str)
    end
    body.transform_keys { |k| k.camelize(:lower).to_sym }.to_json
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
      "accepted_policy_id" => x["accepted_policy_id"],
      "uk_degree_grade_id" => x["uk_degree_grade_id"].to_i,
      "degree_status_id" => x["degree_status_id"].to_i,
      "degree_type_id" => x["degree_type_id"].to_i,
      "initial_teacher_training_year_id" => x["initial_teacher_training_year_id"].to_i,
      "preferred_education_phase_id" => x["preferred_education_phase_id"].to_i,
      "has_gcse_maths_and_english_id" => x["has_gcse_maths_and_english_id"].to_i,
      "has_gcse_science_id" => x["has_gcse_science_id"].to_i,
      "planning_to_retake_gcse_maths_and_english_id" => x["planning_to_retake_gcse_maths_and_english_id"].to_i,
      "planning_to_retake_gcse_science_id" => x["planning_to_retake_gcse_science_id"].to_i,
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
