module DateFields

  def make_a_date(start_year, end_year)
    # validation checks
    year = self.send("callback_date(1i)").to_i 
    month = self.send("callback_date(2i)").to_i
    day = self.send("callback_date(3i)").to_i
  
    return if year < start_year || year > end_year
    
    begin # catch invalid dates, e.g. 31 Feb
      self.callback_date = Date.new(year, month, day)
    rescue ArgumentError
      return
    end
  end

=begin
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
      return if set_values.include?(0)
      return if set_values[0] < 1920 || set_values[0] > Date.today.year
      return if set_values[1] < 1 || set_values[1] > 12
      return if set_values[2] < 1 || set_values[2] > 31
 
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
=end
end