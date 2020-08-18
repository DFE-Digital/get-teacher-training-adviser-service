class StageInterestedTeaching < Base
  extend ApiOptions

  attribute :preferred_education_phase_id, :integer

  validates :preferred_education_phase_id, types: { method: :get_candidate_preferred_education_phases, message: "You must select either primary or secondary" }

  OPTIONS = { primary: 222_750_000, secondary: 222_750_001 }.freeze

  def self.options
    generate_api_options(ApiClient.get_candidate_preferred_education_phases)
  end
end
