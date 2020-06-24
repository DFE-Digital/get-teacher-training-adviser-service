class QualifiedToTeach < Base
  attribute :qualified_subject, :string

  validates :qualified_subject, presence: true 

  def next_step
    "date_of_birth" 
  end

end 