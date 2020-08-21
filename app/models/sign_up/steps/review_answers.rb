module SignUp::Steps
  class ReviewAnswers < Wizard::Step
    attribute :confirmed, :boolean, default: -> { true }

    validates :confirmed, inclusion: { in: [true] }
  end
end
