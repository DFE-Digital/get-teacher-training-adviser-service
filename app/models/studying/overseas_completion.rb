module Studying
  class OverseasCompletion < OverseasCompletion
    def next_step
      return "studying/accept_privacy_policy" if confirmed

      nil
    end
  end
end
