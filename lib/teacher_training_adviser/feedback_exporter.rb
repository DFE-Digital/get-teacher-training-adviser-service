require "csv"

module TeacherTrainingAdviser
  class FeedbackExporter
    EXPORTABLE_ATTRS = %w[
      id
      rating
      successful_visit
      unsuccessful_visit_explanation
      improvements
      created_at
    ].freeze

    def initialize(feedback)
      @feedback = feedback
    end

    def to_csv
      CSV.generate do |csv|
        csv << EXPORTABLE_ATTRS
        @feedback.each do |f|
          csv << f.attributes
            .select { |k, _| EXPORTABLE_ATTRS.include?(k) }
            .values
        end
      end
    end
  end
end
