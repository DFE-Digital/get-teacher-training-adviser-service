class PrimaryRetakeEnglishMaths < Base
  attribute :retaking_english_maths, :boolean

  validates :retaking_english_maths, inclusion: { in: [ true, false ], message: "You must select either yes or no"}

  def next_step
    if retaking_english_maths == true
      "retake_science"
    else
      "qualification_required"
    end
  end

end 