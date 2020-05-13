class ReturningTeacher < Base
  attribute :returning_to_teaching, :boolean

  validates :returning_to_teaching, inclusion: { in: [true,false] }

  def next_step
    if returning_to_teaching == true
      "primary_or_secondary"
    else
      "have_a_degree"
    end
  end


end