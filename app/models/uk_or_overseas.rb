class UkOrOverseas < Base
  attribute :uk_or_overseas, :string
  
  validates :uk_or_overseas, types: { method: :get_candidate_locations, message: "Select if you live in the UK or overseas" }
  
  LOCATIONS = { uk: "222750000", overseas: "222750001" }
  
  def next_step
    if uk_or_overseas == LOCATIONS[:uk]
      "uk_candidate"
    else
      "overseas_country"
    end
  end
end