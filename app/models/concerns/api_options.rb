module ApiOptions
  def generate_api_options(types_method_call, omit_ids = [], include_ids = [])
    api = GetIntoTeachingApiClient::TypesApi.new

    types = api.send(types_method_call)

    types.reject! { |type| omit_ids.include?(type.id) } if omit_ids.present?
    types.select! { |type| include_ids.include?(type.id) } if include_ids.present?

    types.reduce({}) { |options, type| options.update(type.value => type.id.to_s) }
  end
end
