module Equivalent
  class OverseasCompletion < OverseasCompletion
    def next_step
      return "equivalent/accept_privacy_policy" if confirmed

      nil
    end
  end
end
