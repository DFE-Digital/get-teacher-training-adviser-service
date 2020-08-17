class HaveADegree < Base
  attribute :degree_options, :string
  attribute :degree_status_id, :string
  attribute :degree_type_id, :string

  before_validation :set_degree_status
  before_validation :set_degree_type

<<<<<<< HEAD
  DEGREE_OPTIONS = { yes: "yes", no: "no", studying: "studying", equivalent: "equivalent" }.freeze
  DEGREE_STATUS_OPTIONS = { yes: "222750000", no: "222750004", studying: "studying" }.freeze
  DEGREE_TYPE = { degree: "222750000", equivalent: "222750005" }.freeze

  validates :degree_options, inclusion: { in: DEGREE_OPTIONS.map { |_k, v| v }, message: "Select an option from the list" }
  validates :degree_status_id, inclusion: { in: DEGREE_STATUS_OPTIONS.map { |_k, v| v }, message: "Select an option from the list" }
  validates :degree_type_id, types: { method: :get_qualification_types }

  def set_degree_status
    self.degree_status_id = case degree_options
                            when DEGREE_OPTIONS[:no]
                              DEGREE_STATUS_OPTIONS[:no]
                            when DEGREE_OPTIONS[:studying]
                              DEGREE_STATUS_OPTIONS[:studying]
                            else
                              DEGREE_STATUS_OPTIONS[:yes]
    end
  end

  def set_degree_type
    self.degree_type_id = case degree_options
                          when DEGREE_OPTIONS[:equivalent]
                            DEGREE_TYPE[:equivalent]
=======
  OPTIONS = { yes: "222750000", no: "222750004", studying: "studying", equivalent: "222750005" }.freeze
  DEGREE_TYPE = { degree: "222750000", other: "222750005" }.freeze
  # DEGREE_TYPE = { degree: "222750000", equivalent: "222750005" }.freeze

  validates :degree_status_id, inclusion: { in: OPTIONS.map { |_k, v| v }, message: "Select an option from the list" }
  validates :degree_type_id, types: { method: :get_qualification_types }

  def set_degree_type
    self.degree_type_id = case degree_status_id
                          when OPTIONS[:no]
                            DEGREE_TYPE[:other]
>>>>>>> 0c61908... pre change have_a_degree
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
    case degree_options
    when DEGREE_OPTIONS[:yes]
      "degree/what_subject_degree"
    when DEGREE_OPTIONS[:no]
      "no_degree"
    when DEGREE_OPTIONS[:studying]
      "studying/stage_of_degree"
    else
      "equivalent/stage_interested_teaching"
    end
  end
end
