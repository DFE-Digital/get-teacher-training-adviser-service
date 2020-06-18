class HaveADegree < Base
  attribute :degree, :string
  
  validates :degree, types: { method: :get_qualification_degree_status, message: "You must select an option" }

  # TODO: need mapping correctly once the data is updated in CRM
  OPTIONS = { yes: "222750004", no: "222750006", studying: "222750002", equivalent: "222750005" }

  def next_step
    case
    when degree == OPTIONS[:yes]
      "degree/what_subject_degree"
    when degree == OPTIONS[:no]
      "no_degree"
    when degree == OPTIONS[:studying]
      "degree/what_subject_degree"
    when degree == OPTIONS[:equivalent]
      "equivalent/stage_interested_teaching"
    end
  end
end