class SecondaryMathsEnglishGrade4 < Base
  attribute :has_required_subjects, :string

  validates :has_required_subjects, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

  OPTIONS = Crm::OPTIONS
end
