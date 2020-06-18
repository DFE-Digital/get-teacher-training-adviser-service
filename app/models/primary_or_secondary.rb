class PrimaryOrSecondary < Base
  attribute :primary_or_secondary, :string

  validates :primary_or_secondary, types: { 
    method: :get_candidate_preferred_education_phases, message: "Select if you are qualified to teach primary or secondary" 
  }

  STAGES = { primary: "222750000", secondary: "222750001" }

  def next_step
    "qualified_to_teach" 
  end
end 