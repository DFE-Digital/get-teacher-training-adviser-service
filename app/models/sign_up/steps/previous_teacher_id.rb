module SignUp::Steps
  class PreviousTeacherId < Wizard::Step
    attribute :teacher_id, :string

    def skipped?
      !@store["returning_to_teaching"]
    end
  end
end
