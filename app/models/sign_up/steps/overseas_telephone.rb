module SignUp::Steps
  class OverseasTelephone < Wizard::Step
    attribute :telephone, :string

    validates :telephone,
              length: { in: 5..20,
                        too_short: "Telephone number is too short (minimum is 5 characters)",
                        too_long: "Telephone number is too long (maximum is 20 characters)" },
              format: { with: /\A[0-9\s+]+\z/, message: "Enter a telephone number in the correct format" },
              allow_blank: true

    def skipped?
      @store["uk_or_overseas"] == SignUp::Steps::UkOrOverseas::OPTIONS[:uk]
    end
  end
end
