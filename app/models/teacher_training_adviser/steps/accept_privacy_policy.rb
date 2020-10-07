module TeacherTrainingAdviser::Steps
  class AcceptPrivacyPolicy < Wizard::Step
    attribute :accepted_policy_id, :string

    validates :accepted_policy_id, policy: { method: :get_privacy_policy }

    def reviewable_answers
      {}
    end
  end
end
