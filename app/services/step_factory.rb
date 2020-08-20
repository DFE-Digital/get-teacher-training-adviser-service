class StepFactory
  class NameNotFoundError < StandardError
    attr_reader :name
    def initialize(name)
      super
      @name = name
    end

    def message
      "Step name not found for #{name}"
    end
  end

  class << self
    def create(name)
      classified_name = name.camelize

      Object.const_get(classified_name).new
    rescue StandardError
      # need to redirect to root or last valid step.
      raise NameNotFoundError, classified_name
    end
    alias_method :create!, :create
  end
end
