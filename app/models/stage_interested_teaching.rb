class StageInterestedTeaching < Base
  attribute :primary_or_secondary, :string

  validates :primary_or_secondary, types: { 
    method: :get_candidate_preferred_education_phases, message: "You must select 'primary', 'primary with maths' or 'secondary'" 
  }

  STAGES = { primary: "222750000", secondary: "222750001" }

  def next_step
    if primary_or_secondary == STAGES[:secondary]
      "secondary_maths_english_grade4"
    else 
      "science_grade4"
    end
  end

end 