class HaveADegree < Base
  attribute :degree_status_id, :integer
  attribute :degree_type_id, :integer

  before_validation :set_degree_type

  STUDYING = -1 # degree_status_id will be overriden on subsequent step.
  OPTIONS = { yes: 222_750_000, no: 222_750_004, studying: STUDYING, equivalent: 222_750_005 }.freeze
  DEGREE_TYPE = { degree: 222_750_000, equivalent: 222_750_005 }.freeze

  validates :degree_status_id, inclusion: { in: OPTIONS.map { |_k, v| v }, message: "Select an option from the list" }
  validates :degree_type_id, types: { method: :get_qualification_degree_status }

  def set_degree_type
    self.degree_type_id = case degree_status_id
                          when OPTIONS[:equivalent]
                            DEGREE_TYPE[:equivalent]
                          else
                            DEGREE_TYPE[:degree]
                          end
  end

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
