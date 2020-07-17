class HaveADegree < Base
  attribute :degree, :string
  attribute :degree_type, :string

  before_validation :set_degree_type

  validates :degree, types: { method: :get_qualification_degree_status, message: "You must select an option" }
  validates :degree_type, types: { method: :get_qualification_degree_status }
  # may need updating
  OPTIONS = { yes: "222750000", no: "222750004", studying: "222750001", equivalent: "222750005" }.freeze
  DEGREE_TYPE = { degree: "222750000", equivalent: "222750005" }

  def set_degree_type
    case degree
    when OPTIONS[:equivalent]
      self.degree_type = DEGREE_TYPE[:equivalent]
    else
      self.degree_type = DEGREE_TYPE[:degree]
    end
  end

  def next_step
    case degree
    when OPTIONS[:yes]
      "degree/what_subject_degree"
    when OPTIONS[:no]
      "no_degree"
    when OPTIONS[:studying]
      "studying/stage_of_degree"
    else
      "equivalent/stage_interested_teaching"
    end
  end
end
