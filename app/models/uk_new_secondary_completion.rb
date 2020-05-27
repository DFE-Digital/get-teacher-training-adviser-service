class UkNewSecondaryCompletion < Base
  attribute :confirmed, :boolean, default: false

  validates :confirmed, inclusion: { in: [true, false] }

  def next_step
    return "opt_in_emails" if confirmed
    nil
  end
end