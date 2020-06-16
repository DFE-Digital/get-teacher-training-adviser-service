class PreviousId < Base
  attribute :id, :string

  validates :id, presence: { message: "Please enter your previous teacher ID number" } # is this numeric?

  def next_step
    "previous_subject"
  end

end 