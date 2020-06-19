class PrimaryRetakeEnglishMaths < Base
  attribute :retaking_english_maths, :string

  validates :retaking_english_maths, inclusion: { in: %w(yes no), message: "You must select an option"}

  def next_step
    if retaking_english_maths == "yes"
      "retake_science"
    else
      "qualification_required"
    end
  end

end 