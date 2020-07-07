class PrimaryMathsEnglishGrade4 < Base
  attribute :has_required_subjects, :string

  validates :has_required_subjects, types: { method: :get_candidate_gcse_status, message: "You must select either yes or no" }

  OPTIONS = { yes: "222750001", no: "222750000" }.freeze
end
