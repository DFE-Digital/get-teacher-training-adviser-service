module Equivalent
  class UkOrOverseas < UkOrOverseas
    def next_step
      if uk_or_overseas == "UK"
        "equivalent/uk_candidate"
      else
        "equivalent/overseas_country"
      end
    end
  end
end