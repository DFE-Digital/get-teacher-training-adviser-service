class RetakeEnglishMaths < Base
  attribute :planning_to_retake_gcse_maths_and_english_id, :integer

  validates :planning_to_retake_gcse_maths_and_english_id, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

  OPTIONS = Crm::OPTIONS
end
