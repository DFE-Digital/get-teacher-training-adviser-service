module Degree
  class AcceptPrivacyPolicy < AcceptPrivacyPolicy
    def next_step
      return "complete_application" if valid?

      nil
    end
  end
end