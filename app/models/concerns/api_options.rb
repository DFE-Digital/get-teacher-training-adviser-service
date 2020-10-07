module ApiOptions
  def generate_api_options(types_method_call, omit_ids = [])
    api = GetIntoTeachingApiClient::TypesApi.new

    types = api.send(types_method_call).reject do |type|
      omit_ids.include?(type.id)
    end

    types.reduce({}) { |options, type| options.update(type.value => type.id.to_s) }
  end
end
