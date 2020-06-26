module Equivalent
  class Equivalent::StageInterestedTeaching < Base
    attribute :primary_or_secondary, :string

    validates :primary_or_secondary, inclusion: { in: %w[primary secondary], message: "You must select primary or secondary" }

    def next_step
      "equivalent/subject_interested_teaching"
    end
  end
end
