class RetakeScience < Base
  attribute :retaking_science, :string

  validates :retaking_science, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

  OPTIONS = { yes: "222750000", no: "222750001" }.freeze
end
