class PrimaryMathsEnglishGrade4 < Base
  attribute :has_required_subjects, :boolean

  validates :has_required_subjects, inclusion: { in: [ true, false ], message: "You must select an option"}

  def next_step
    if has_required_subjects == true
      "subject_interested_teaching"
    else
      "qualification_required"
    end
  end


end 