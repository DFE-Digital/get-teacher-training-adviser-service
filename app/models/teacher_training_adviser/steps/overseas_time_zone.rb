module TeacherTrainingAdviser::Steps
  class OverseasTimeZone < Wizard::Step
    attribute :telephone, :string

    validates :telephone, telephone: true, presence: true

    def reviewable_answers
      {
        "telephone" => telephone,
      }
    end

    def skipped?
      overseas_country_skipped = other_step(:overseas_country).skipped?
      degree_options = other_step(:have_a_degree).degree_options
      equivalent_degree = degree_options == HaveADegree::DEGREE_OPTIONS[:equivalent]

      overseas_country_skipped || !equivalent_degree
    end
  end
end
