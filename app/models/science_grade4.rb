class ScienceGrade4 < Base
  attribute :have_science, :string

  validates :have_science, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

  OPTIONS = { yes: "222750000", no: "222750001" }.freeze
end
