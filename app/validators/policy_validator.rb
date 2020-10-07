class PolicyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      policy = GetIntoTeachingApiClient::PrivacyPoliciesApi.new.send(options[:method], value) if value.present?
    rescue GetIntoTeachingApiClient::ApiError => e
      Rails.logger.error e # how do we handle a Bad Request ?
    end

    unless policy
      record.errors.add(attribute, :invalid_policy)
    end
  end
end
