module TeacherTrainingAdviser::Steps
  class Identity < ::Wizard::Step
    include Wizard::IssueVerificationCode

    attribute :first_name, :string
    attribute :last_name, :string
    attribute :email, :string

    validates :first_name, presence: true, length: { maximum: 256 }
    validates :last_name, presence: true, length: { maximum: 256 }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, length: { maximum: 100 }

    before_validation :sanitize_input

    def self.contains_personal_details?
      true
    end

    def reviewable_answers
      super
        .tap { |answers|
          answers["name"] = "#{answers['first_name']} #{answers['last_name']}"
        }
        .without("first_name", "last_name")
    end

  private

    def sanitize_input
      self.first_name = first_name.to_s.strip.presence if first_name
      self.last_name = last_name.to_s.strip.presence if last_name
      self.email = email.to_s.strip.presence if email
    end
  end
end
