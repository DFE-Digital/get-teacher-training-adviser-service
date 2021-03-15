module TeacherTrainingAdviser::Steps
  class UkCallback < Wizard::Step
    extend CallbackBookingQuotas

    attribute :telephone, :string
    attribute :phone_call_scheduled_at, :datetime

    validates :telephone, telephone: true, presence: true
    validates :phone_call_scheduled_at, presence: true

    before_validation if: :telephone do
      self.telephone = telephone.to_s.strip.presence
    end

    def self.contains_personal_details?
      true
    end

    def reviewable_answers
      {
        "telephone" => telephone,
        "callback_date" => phone_call_scheduled_at&.to_date,
        "callback_time" => phone_call_scheduled_at&.to_time, # rubocop:disable Rails/Date
      }
    end

    def skipped?
      uk_address_skipped = other_step(:uk_address).skipped?
      have_a_degree_step = other_step(:have_a_degree)
      have_a_degree_skipped = have_a_degree_step.skipped?
      equivalent_degree = have_a_degree_step.degree_options == HaveADegree::DEGREE_OPTIONS[:equivalent]

      uk_address_skipped || have_a_degree_skipped || !equivalent_degree
    end
  end
end
