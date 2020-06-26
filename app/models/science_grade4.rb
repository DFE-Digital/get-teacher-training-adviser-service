class ScienceGrade4 < Base
  attribute :have_science, :string

  validates :have_science, inclusion: { in: %w(yes no), message: "You must select an option" }

  def next_step
    if have_science == "yes"
      "primary_maths_english_grade4"
    else
      "qualification_required"
    end
  end
end
