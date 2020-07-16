class RetakeEnglishMaths < Base
  attribute :retaking_english_maths, :string

  validates :retaking_english_maths, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

  OPTIONS = Crm::OPTIONS
end
