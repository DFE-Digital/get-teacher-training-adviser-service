module Degree
  class UkOrOverseas < UkOrOverseas
    def next_step
      if uk_or_overseas == "UK"
        "degree/uk_candidate"
      else
        "degree/overseas_candidate"
      end
    end
  end
end