class QualifiedToTeach < Base
  attribute :qualified_subject, :string

  validates :qualified_subject, types: { method: :get_teaching_subjects }

  def next_step
    "date_of_birth" 
  end
end 