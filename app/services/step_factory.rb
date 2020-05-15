class StepFactory
# need to register permitted classes
  def self.create(name)
    classified_name = name.camelize
    Object.const_get(classified_name).new
  end
  
end