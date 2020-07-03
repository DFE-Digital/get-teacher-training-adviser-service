class HaveADegree < Base
  attribute :degree, :string

  validates :degree, types: { method: :get_qualification_degree_status, message: "You must select an option" }
  # may need updating
  OPTIONS  = { yes: "222750000", no: "222750004", studying: "222750001", equivalent: "222750005" }

  def next_step
    if degree == OPTIONS[:yes]
      "degree/what_subject_degree"
    elsif degree == OPTIONS[:no]
      "no_degree"
    elsif degree == OPTIONS[:studying]
      "studying/what_subject_degree"
    elsif degree == OPTIONS[:equivalent]
      "equivalent/stage_interested_teaching"
    end
  end
end
