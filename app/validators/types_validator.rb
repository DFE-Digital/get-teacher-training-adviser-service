
class TypesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    types = ApiClient.send(options[:method])

    unless types.map(&:id).include?(value)
      record.errors[attribute] << (options[:message] || "is not included in the list")
    end
  end
end
