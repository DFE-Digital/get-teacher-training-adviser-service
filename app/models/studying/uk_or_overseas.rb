module Studying
  class UkOrOverseas < UkOrOverseas
    def next_step
      if uk_or_overseas == LOCATIONS[:uk]
        "studying/uk_candidate"
      else
        "studying/overseas_country"
      end
    end
  end
end
