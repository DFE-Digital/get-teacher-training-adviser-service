class HaveADegree < Base
  attribute :degree, :string

  validates :degree, inclusion: { in: %w(yes no studying equivalent), message: "You must select an option" }

  def next_step
    if degree == "yes"
      "degree/what_subject_degree"
    elsif degree == "no"
      "no_degree"
    elsif degree == "studying"
      "studying/what_subject_degree"
    elsif degree == "equivalent"
      "equivalent/stage_interested_teaching"
    end
  end
end
