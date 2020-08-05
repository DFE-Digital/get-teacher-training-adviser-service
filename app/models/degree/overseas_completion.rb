module Degree
  class OverseasCompletion < OverseasCompletion
    def next_step
      return "degree/accept_privacy_policy" if confirmed

      nil
    end
  end
end
