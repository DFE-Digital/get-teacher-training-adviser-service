module Studying
  class OverseasCompletion < OverseasCompletion
    def next_step
      return "accept_privacy_policy" if confirmed
      nil
    end
  end
end