module SignUp::Steps
  class OverseasCallback < UkCallback
    attribute :time_zone, :string

    validates :time_zone, presence: { message: "Select a time zone" }

    def skipped?
      @store["returning_to_teaching"] ||
        @store["degree_options"] != HaveADegree::DEGREE_OPTIONS[:equivalent] ||
        @store["uk_or_overseas"] != "overseas"
    end
  end
end
