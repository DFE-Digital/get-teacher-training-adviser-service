class RetakeScience < Base
  attribute :retaking_science, :boolean

  validates :retaking_science, inclusion: { in: [ true, false ], message: "You must select either yes or no"}

  def next_step
    if retaking_science == true
      "start_teacher_training"
    else
      "qualification_required"
    end
  end

end 