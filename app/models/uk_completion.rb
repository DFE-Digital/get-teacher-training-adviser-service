class UkCompletion < Base
  attribute :confirmed, :boolean, default: false

  validates :confirmed, inclusion: { in: [true, false] }

  def next_step
    if confirmed == true
      "opt_in_emails"
    else
      nil
    end
  end
end