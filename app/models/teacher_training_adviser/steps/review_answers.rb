module TeacherTrainingAdviser::Steps
  class ReviewAnswers < Wizard::Step
    attribute :confirmed, :boolean, default: -> { true }

    validates :confirmed, inclusion: { in: [true] }

    def answers
      @answers ||= @wizard.export_data
    end
  end
end
