class PolicyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      policy = ApiClient.send(options[:method], value)
    rescue GetIntoTeachingApiClient::ApiError => e
      Rails.logger.error e # how do we handle a Bad Request ?
    end

    unless policy
      record.errors[attribute] << (options[:message] || "is not included in the list")
    end
  end
end
