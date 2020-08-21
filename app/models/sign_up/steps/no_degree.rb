module SignUp::Steps
  class NoDegree < Wizard::Step
    def can_proceed?
      false
    end

    def skipped?
      @store["degree_options"] != HaveADegree::DEGREE_OPTIONS[:no]
    end
  end
end
