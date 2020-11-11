class PolicyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      policy = GetIntoTeachingApiClient::PrivacyPoliciesApi.new.get_privacy_policy(value) if value.present?
    rescue GetIntoTeachingApiClient::ApiError => e
      raise unless e.code == 400
    end

    unless policy
      record.errors.add(attribute, :invalid_policy)
    end
  end
end
