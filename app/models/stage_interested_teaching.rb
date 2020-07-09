class StageInterestedTeaching < Base
  attribute :primary_or_secondary, :string

  validates :primary_or_secondary, types: { method: :get_candidate_preferred_education_phases, message: "You must select either primary or secondary" }

  OPTIONS = { primary: "222750000", secondary: "222750001" }.freeze
end
