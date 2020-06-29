class StageInterestedTeaching < Base
  attribute :primary_or_secondary, :string

  validates :primary_or_secondary, inclusion: { in: ["primary", "primary with maths", "secondary"], message: "You must select primary, primary with maths or secondary" }

  def next_step
    if primary_or_secondary == "secondary"
      "secondary_maths_english_grade4"
    else
      "science_grade4"
    end
  end
end
