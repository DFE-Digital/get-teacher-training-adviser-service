class Dob < Base

  attribute :date_of_birth, :datetime
  
  validates :date_of_birth, presence: true
  
  def next_step
   "uk_or_overseas" 
  end

  def initialize(attributes = nil)
    super

    assign_attributes(attributes) if attributes
  end

  def assign_attributes(attributes)
    new_attributes = attributes.stringify_keys
    multiparameter_attributes = extract_multiparameter_attributes(new_attributes)

    multiparameter_attributes.each do |multiparameter_attribute, values_hash|
      set_values = (1..3).collect{ |position| values_hash[position].to_i }
      
    # validation checks
    if set_values.include?(0)
      return
    elsif set_values[0] < 1920 || set_values[0] > Date.today.year
      return
    elsif set_values[1] < 1 || set_values[1] > 12
      return
    elsif set_values[2] < 1 || set_values[2] > 31
      return
    end
  
      self.send("#{multiparameter_attribute}=", Date.new(*set_values))
    end
  end

  protected

  def extract_multiparameter_attributes(new_attributes)
    multiparameter_attributes = []

    new_attributes.each do |k, v|
      if k.include?('(')
        multiparameter_attributes << [k, v]
      end
    end

    extract_attributes(multiparameter_attributes)
  end

  def extract_attributes(pairs)
    attributes = {}

    pairs.each do |pair|
      multiparameter_name, value = pair
      attribute_name = multiparameter_name.split('(').first
      attributes[attribute_name] = {} unless attributes.include?(attribute_name)

      attributes[attribute_name][find_parameter_position(multiparameter_name)] ||= value
    end

    attributes
  end

  def find_parameter_position(multiparameter_name)
    multiparameter_name.scan(/\(([0-9]*).*\)/).first.first.to_i
  end  

end 
