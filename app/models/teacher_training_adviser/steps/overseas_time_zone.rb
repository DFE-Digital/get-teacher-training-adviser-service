module TeacherTrainingAdviser::Steps
  class OverseasTimeZone < Wizard::Step
    attribute :telephone, :string
    attribute :time_zone, :string

    validates :telephone, telephone: true, presence: true
    validates :time_zone, presence: true, unless: -> { Rails.env.production? }

    def self.contains_personal_details?
      true
    end

    def filtered_time_zones
      ActiveSupport::TimeZone.all.drop(1)
    end

    def reviewable_answers
      { "telephone" => telephone }.tap do |answers|
        answers["time_zone"] = time_zone if time_zone.present?
      end
    end

    def skipped?
      overseas_country_skipped = other_step(:overseas_country).skipped?
      degree_options = other_step(:have_a_degree).degree_options
      equivalent_degree = degree_options == HaveADegree::DEGREE_OPTIONS[:equivalent]

      overseas_country_skipped || !equivalent_degree
    end
  end
end
