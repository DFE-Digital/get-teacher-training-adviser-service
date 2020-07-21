class RetakeScience < Base
  attribute :planning_to_retake_cgse_science_id, :string

  validates :planning_to_retake_cgse_science_id, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

  OPTIONS = Crm::OPTIONS
end
