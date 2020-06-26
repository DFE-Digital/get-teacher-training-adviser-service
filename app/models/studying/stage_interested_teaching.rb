module Studying
  class StageInterestedTeaching < Base
    attribute :primary_or_secondary, :string

    validates :primary_or_secondary, inclusion: { in: %w[primary secondary], message: "You must select primary or secondary" }

    def next_step
      if primary_or_secondary == "secondary"
        "studying/secondary_maths_english_grade4"
      else
        "studying/primary_maths_english_grade4"
      end
    end
  end
end
