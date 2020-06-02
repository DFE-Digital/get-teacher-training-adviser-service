module Equivalent
  class UkOrOverseas < UkOrOverseas
    def next_step
      if uk_or_overseas == "uk"
        "equivalent/uk_candidate"
      else
        "equivalent/overseas_candidate"
      end
    end
  end
end