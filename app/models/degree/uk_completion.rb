module Degree
  class UkCompletion < UkCompletion
    def next_step
      return "degree/opt_in_emails" if confirmed
      nil
    end
  end
end