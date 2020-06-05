class UkOrOverseas < Base
  attribute :uk_or_overseas, :string
  
  validates :uk_or_overseas, inclusion: { in: %w(UK overseas), message: "Select if you live in the UK or overseas" }

  def next_step
    if uk_or_overseas == "UK"
      "uk_candidate"
    else
      "overseas_candidate"
    end
  end
end