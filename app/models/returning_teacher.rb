class ReturningTeacher < Base
  attribute :returning_to_teaching, :string

  validates :returning_to_teaching, inclusion: { in: %w(yes no), message: "Please answer yes or no."}

  def next_step
    if returning_to_teaching == "yes"
      "primary_or_secondary"
    else
      "have_a_degree"
    end
  end


end 