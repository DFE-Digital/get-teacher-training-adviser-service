class StageInterestedTeaching < Base
  attribute :primary_or_secondary, :string

  validates :primary_or_secondary, inclusion: { in: %w(primary secondary), message: "You must select an option" }

  def next_step
    if primary_or_secondary == "primary"
      "science_grade4"
    else
      "secondary_maths_english_grade4" 
    end
  end

end 