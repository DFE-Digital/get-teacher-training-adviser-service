class RetakeScience < Base
  attribute :planning_to_retake_gcse_science_id, :integer

  validates :planning_to_retake_gcse_science_id, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

  OPTIONS = Crm::OPTIONS
end
