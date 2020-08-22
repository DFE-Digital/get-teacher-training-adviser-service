module TeacherTrainingAdviser::Steps
  class AcceptPrivacyPolicy < Wizard::Step
    attribute :accepted_policy_id, :string

    validates :accepted_policy_id, policy: { method: :get_privacy_policy, message: "You must accept the privacy policy in order to talk to a teacher training adviser" }
  end
end
