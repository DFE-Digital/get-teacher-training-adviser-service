class RetakeScience < Base
  attribute :retaking_science, :string

  validates :retaking_science, types: { method: :get_candidate_gcse_status, message: "You must select either yes or no" }

  OPTIONS = { yes: "222750001", no: "222750000" }.freeze
end
