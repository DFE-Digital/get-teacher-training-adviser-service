class PreviousId < Base
  attribute :prev_id, :string

  # no validation required as optional

  def next_step
    "previous_subject"
  end
end
