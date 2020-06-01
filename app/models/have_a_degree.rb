class HaveADegree < Base
  attribute :degree, :string
  
  validates :degree, inclusion: { in: %w(yes no studying equivalent), message: "You must select an option"}

  def next_step
    case
    when degree == "yes"
      "degree/what_subject_degree"
    when degree == "no"
      "no_degree"
    when degree == "studying"
      "degree/what_subject_degree"
    when degree == "equivalent"
      "equivalent/stage_interested_teaching"
    end
  end
end