class RetakeEnglishMaths < Base
  attribute :retaking_english_maths, :boolean

  validates :retaking_english_maths, inclusion: { in: [true, false], message: "You must select either yes or no"}

  def next_step
    if retaking_english_maths == true
      "subject_interested_teaching"
    else
      "qualification_required"
    end
  end

end 