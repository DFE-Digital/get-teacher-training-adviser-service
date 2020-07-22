class ScienceGrade4 < Base
  attribute :has_gcse_science_id, :string

  validates :has_gcse_science_id, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

  OPTIONS = Crm::OPTIONS
end
