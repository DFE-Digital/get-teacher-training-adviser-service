class OverseasCandidate < Callback
  attribute :time_zone, :string

  validates :time_zone, presence: { message: "Select a time zone" }

  def next_step
    "overseas_completion"
  end
end
