class QualifiedToTeach < Base
  attribute :qualified_subject, :string

  validates :qualified_subject, inclusion: { in: %w(Maths English Science History) }

  def next_step
    "date_of_birth"
  end

end 