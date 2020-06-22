module Studying
  class UkCompletion < UkCompletion
    def next_step
      return "accept_privacy_policy" if confirmed
      nil
    end
  end
end