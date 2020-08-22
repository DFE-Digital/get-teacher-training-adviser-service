class TypesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    types = GetIntoTeachingApiClient::TypesApi.new.send(options[:method])

    unless types.map { |type| type.id.to_s }.include?(value.to_s)
      record.errors[attribute] << (options[:message] || "is not included in the list")
    end
  end
end
