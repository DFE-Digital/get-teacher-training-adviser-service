class StageInterestedTeaching < Base
  attribute :preferred_education_phase_id, :string

  validates :preferred_education_phase_id, types: { method: :get_candidate_preferred_education_phases, message: "You must select either primary or secondary" }

  OPTIONS = { primary: "222750000", secondary: "222750001" }.freeze
end
