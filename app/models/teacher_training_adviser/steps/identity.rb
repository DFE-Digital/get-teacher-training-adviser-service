module TeacherTrainingAdviser::Steps
  class Identity < ::Wizard::Step
    attribute :email, :string
    attribute :first_name, :string
    attribute :last_name, :string

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "You need to enter you email address" }, length: { maximum: 100 }
    validates :first_name, presence: { message: "You need to enter your first name" }, length: { maximum: 256 }
    validates :last_name, presence: { message: "You need to enter your last name" }, length: { maximum: 256 }
  end
end
