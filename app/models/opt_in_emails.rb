class OptInEmails < Base
  attribute :confirmed, :boolean, default: false

  validates :confirmed, inclusion: { in: [true, false] }

  def next_step
    if confirmed == true
      "privacy_policy"
    else
      nil
    end
  end
end