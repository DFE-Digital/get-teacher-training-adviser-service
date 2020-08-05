module Degree
  class UkCompletion < UkCompletion
    def next_step
      return "degree/accept_privacy_policy" if confirmed

      nil
    end
  end
end
