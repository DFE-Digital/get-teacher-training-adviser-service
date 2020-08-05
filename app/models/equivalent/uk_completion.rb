module Equivalent
  class UkCompletion < UkCompletion
    def next_step
      return "equivalent/accept_privacy_policy" if confirmed

      nil
    end
  end
end
