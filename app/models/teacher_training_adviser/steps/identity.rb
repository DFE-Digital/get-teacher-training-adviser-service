module TeacherTrainingAdviser::Steps
  class Identity < ::Wizard::Step
    include Wizard::IssueVerificationCode

    attribute :email, :string
    attribute :first_name, :string
    attribute :last_name, :string

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "You need to enter you email address" }, length: { maximum: 100 }
    validates :first_name, presence: { message: "You need to enter your first name" }, length: { maximum: 256 }
    validates :last_name, presence: { message: "You need to enter your last name" }, length: { maximum: 256 }

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
