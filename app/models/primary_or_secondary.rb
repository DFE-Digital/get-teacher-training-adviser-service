class PrimaryOrSecondary < Base
  attribute :primary_or_secondary, :string

  validates :primary_or_secondary, inclusion: { in: %w(primary secondary), message: "You must select an option" }

  def next_step
    "qualified_to_teach" 
  end

end 