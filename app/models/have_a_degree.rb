class HaveADegree < Base
  attribute :degree_status_id, :string
  attribute :degree_type_id, :string

  before_validation :set_degree_type

  OPTIONS = { yes: "222750000", no: "222750004", studying: "studying", equivalent: "222750005" }.freeze
  DEGREE_TYPE = { degree: "222750000", other: "222750005" }.freeze
  # DEGREE_TYPE = { degree: "222750000", equivalent: "222750005" }.freeze

  validates :degree_status_id, inclusion: { in: OPTIONS.map { |_k, v| v }, message: "Select an option from the list" }
  validates :degree_type_id, types: { method: :get_qualification_types }

  def set_degree_type
    self.degree_type_id = case degree_status_id
                          when OPTIONS[:no]
                            DEGREE_TYPE[:other]
                          else
                            DEGREE_TYPE[:degree]
                          end
  end

  #self.degree_type_id = case degree_status_id
  #when OPTIONS[:equivalent]
  #  DEGREE_TYPE[:equivalent]
  #else
  #  DEGREE_TYPE[:degree]
  #end

  def next_step
    case degree_status_id
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
