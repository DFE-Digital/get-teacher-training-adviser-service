class RetakeScience < Base
  attribute :retaking_science, :string

  validates :retaking_science, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

  OPTIONS = Crm::OPTIONS
end
