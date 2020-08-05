class CandidateSubmission
  include Candidate

  def initialize(session, step_name)
    @session = session
    @step_name = step_name
  end

  def call
   sign_up_candidate(select_candidate)
  end

  private

  def sign_up_candidate(body)
    ApiClient.sign_up_teacher_training_adviser_candidate(body)
  end

  def select_candidate
    case @step_name
    when "accept_privacy_policy"
      filter_returner_candidate
    when "degree/accept_privacy_policy"
      filter_degree_candidate
    when "studying/accept_privacy_policy"
      filter_studying_candidate
    when "equivalent/accept_privacy_policy"
      filter_equivalent_candidate
    end
  end

  def filter_returner_candidate
    data = @session[:registration].select { |key, _| RETURNER.include? key.to_sym }
    # set default as secondary
    data.merge!({ "preferred_education_phase_id" => StageInterestedTeaching::OPTIONS[:secondary].to_i })
    merge_integers(data)
  end

  def filter_degree_candidate
    data = @session[:registration].select { |key, _| DEGREE.include? key.to_sym }
    merge_integers(data)
  end

  def filter_studying_candidate
    data = @session[:registration].select { |key, _| STUDYING.include? key.to_sym }
    merge_integers(data)
  end

  def filter_equivalent_candidate
    data = @session[:registration].select { |key, _| EQUIVALENT.include? key.to_sym }
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

end
