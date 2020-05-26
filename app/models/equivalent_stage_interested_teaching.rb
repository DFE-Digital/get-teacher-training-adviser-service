class EquivalentStageInterestedTeaching < Base
  attribute :primary_or_secondary, :string

  validates :primary_or_secondary, inclusion: { in: %w(primary secondary), message: "Please answer Primary or Secondary." }

  def next_step
    "subject_interested_teaching"
  end

end 