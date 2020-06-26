class UkCompletion < Base
  attribute :confirmed, :boolean, default: false

  validates :confirmed, inclusion: { in: [true, false] }

  def next_step
    return "accept_privacy_policy" if confirmed

    nil
  end
end
