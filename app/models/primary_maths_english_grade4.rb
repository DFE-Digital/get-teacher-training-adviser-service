class PrimaryMathsEnglishGrade4 < Base
  attribute :has_required_subjects, :string

  validates :has_required_subjects, inclusion: { in: %w(yes no), message: "Please answer yes or no."}

  def next_step
    if has_required_subjects == "yes"
      "subject_interested_in_teaching"
    else
      "required_gcse"
    end
  end


end 