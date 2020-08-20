module SignUp::Steps
  class HasTeacherId < Wizard::Step
    attribute :has_id, :boolean

    validates :has_id, inclusion: { in: [true, false], message: "You must select either yes or no" }

    def skipped?
      !@store["returning_to_teaching"]
    end
  end
end
