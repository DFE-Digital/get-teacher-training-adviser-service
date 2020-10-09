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
      overseas_country_skipped = @wizard.all_skipped?(OverseasCountry.key)
      degree_options = @wizard.find(HaveADegree.key).degree_options
      equivalent_degree = degree_options == HaveADegree::DEGREE_OPTIONS[:equivalent]

      overseas_country_skipped || !equivalent_degree
    end
  end
end
