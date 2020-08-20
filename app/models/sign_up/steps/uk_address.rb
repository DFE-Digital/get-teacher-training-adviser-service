module SignUp::Steps
  class UkAddress < Wizard::Step
    attribute :address_line1, :string
    attribute :address_line2, :string
    attribute :address_city, :string
    attribute :address_postcode, :string

    validates :address_line1, presence: { message: "Enter the first line of your address" }
    validates :address_city, presence: { message: "Enter your town or city" }
    validates :address_postcode, format: { with: /^([A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}|GIR ?0A{2})$/i, multiline: true, message: "Enter a real postcode" }

    def skipped?
      @store["uk_or_overseas"] != "UK"
    end
  end
end
