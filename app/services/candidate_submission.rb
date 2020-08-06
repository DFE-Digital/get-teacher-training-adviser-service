class CandidateSubmission
  include Candidate

  def initialize(session)
    @session = session
  end

  def call
    sign_up_candidate(select_candidate)
  end

private

  def sign_up_candidate(body)
    ApiClient.sign_up_teacher_training_adviser_candidate(body)
  end

  def select_candidate
    case @session[:registration]["degree_options"]
    when "returner"
      filter_candidate(RETURNER)
    when "yes"
      filter_candidate(DEGREE)
    when "studying"
      filter_candidate(STUDYING)
    when "equivalent"
      filter_candidate(EQUIVALENT)
    else
      nil
    end
  end

  def filter_candidate(path)
    data = @session[:registration].select { |key, _| path.include? key.to_sym }
    data.merge!({ "preferred_education_phase_id" => StageInterestedTeaching::OPTIONS[:secondary].to_i }) if path == RETURNER
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
