module TeacherTrainingAdviser::Steps
  class HaveADegree < Wizard::Step
    attribute :degree_options, :string
    attribute :degree_status_id, :integer
    attribute :degree_type_id, :integer

    DEGREE_OPTIONS = { degree: "degree", no: "no", studying: "studying", equivalent: "equivalent" }.freeze
    STUDYING = -1 # degree_status_id will be overriden on subsequent step.
    DEGREE_STATUS_OPTIONS = { yes: 222_750_000, no: 222_750_004, studying: STUDYING, first_year: 222_750_003, second_year: 222_750_002, final_year: 222_750_001, equivalent: 222_750_005 }.freeze
    DEGREE_TYPE = { degree: 222_750_000, equivalent: 222_750_005 }.freeze

    validates :degree_options, inclusion: { in: DEGREE_OPTIONS.values, message: "Select an option from the list" }

    with_options if: -> { degree_options.present? } do |degree_option|
      degree_option.validates :degree_status_id, inclusion: { in: DEGREE_STATUS_OPTIONS.values, message: "Select an option from the list" }
      degree_option.validates :degree_type_id, inclusion: { in: DEGREE_TYPE.values }
    end

    def degree_options=(value)
      super
      set_degree_status
      set_degree_type
    end

    def reviewable_answers
      {
        "degree_options" => degree_options.capitalize,
      }
    end

    def skipped?
      @store["returning_to_teaching"]
    end

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
                            else
                              DEGREE_TYPE[:degree]
                            end
    end
  end
end
