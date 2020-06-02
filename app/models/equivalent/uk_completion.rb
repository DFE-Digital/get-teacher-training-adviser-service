module Equivalent
  class UkCompletion < UkCompletion
    def next_step
      return "opt_in_emails" if confirmed
      nil
    end
  end
end