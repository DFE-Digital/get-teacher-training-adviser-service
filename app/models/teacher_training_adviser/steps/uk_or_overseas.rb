module TeacherTrainingAdviser::Steps
  class UkOrOverseas < DFEWizard::Step
    attribute :uk_or_overseas, :string

    OPTIONS = { uk: "UK", overseas: "Overseas" }.freeze

    validates :uk_or_overseas, inclusion: { in: OPTIONS.values }

    def reviewable_answers
      {
        "uk_or_overseas" => uk_or_overseas,
      }
    end
  end
end
