module TeacherTrainingAdviser::Steps
  class Identity < GITWizard::Step
    include ::GITWizard::IssueVerificationCode

    attribute :first_name, :string
    attribute :last_name, :string
    attribute :email, :string
    attribute :channel_id, :integer
    attribute :sub_channel_id

    validates :first_name, presence: true, length: { maximum: 256 }
    validates :last_name, presence: true, length: { maximum: 256 }
    validates :email, presence: true, email_format: true

    before_validation :sanitize_input

    def self.contains_personal_details?
      true
    end

    def export
      super.except("sub_channel_id")
    end

    def reviewable_answers
      super
        .tap { |answers|
          answers["name"] = "#{answers['first_name']} #{answers['last_name']}"
        }
        .without("first_name", "last_name", "channel_id", "sub_channel_id")
    end

    def channel_ids
      query_channels.map { |channel| channel.id.to_i }
    end

    def save
      self.channel_id = nil if channel_invalid?

      super
    end

  private

    def channel_invalid?
      channel_id.present? && !channel_id.in?(channel_ids)
    end

    def query_channels
      @query_channels ||= GetIntoTeachingApiClient::PickListItemsApi.new.get_candidate_teacher_training_adviser_subscription_channels
    end

    def sanitize_input
      self.first_name = first_name.to_s.strip.presence if first_name
      self.last_name = last_name.to_s.strip.presence if last_name
      self.email = email.to_s.strip.presence if email
    end
  end
end
