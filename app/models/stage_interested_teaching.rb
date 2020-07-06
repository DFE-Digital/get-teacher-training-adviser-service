class StageInterestedTeaching < Base
  attribute :primary_or_secondary, :string

  validates :primary_or_secondary, types: { method: :get_candidate_preferred_education_phases, message: "You must select either primary or secondary" }

  # alternative to OPTIONS ?
  #options =  ApiClient::get_candidate_preferred_education_phases
  #secondary = options.find { |option| option.value == "Secondary" }

  OPTIONS = { secondary: "222750001" }.freeze

  def next_step
    if primary_or_secondary == OPTIONS[:secondary]
      "secondary_maths_english_grade4"
    else
      "science_grade4"
    end
  end
end
