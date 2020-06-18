class PreviousId < Base
  attribute :prev_id, :string

  #validates :prev_id, presence: { message: "Please enter your previous teacher ID number" } # is this numeric?

  def next_step
    "previous_subject"
  end

end 