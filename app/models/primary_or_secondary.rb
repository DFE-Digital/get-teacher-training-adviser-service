class PrimaryOrSecondary < Base
  attribute :primary_or_secondary, :string

  validates :primary_or_secondary,inclusion: { in: ["primary", "secondary"] }

  def next_step
    if primary_or_secondary == "primary"
      "primary_teacher"
    else
      "secondary_teacher"
    end
  end

end