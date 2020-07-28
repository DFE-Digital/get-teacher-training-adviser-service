class PolicyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    policy = ApiClient.send(options[:method], value)
  rescue GetIntoTeachingApiClient::ApiError => e
    puts e

    unless policy
      record.errors[attribute] << (options[:message] || "is not included in the list")
    end
  end
end
