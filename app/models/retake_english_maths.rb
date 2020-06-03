class RetakeEnglishMaths < Base
  attribute :retaking, :string

  validates :retaking, inclusion: { in: %w(yes no), message: "You must select an option"}

  def next_step
    if retaking == "yes"
      "subject_interested_teaching"
    else
      "qualification_required"
    end
  end

end 