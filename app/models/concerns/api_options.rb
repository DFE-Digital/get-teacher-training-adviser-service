module ApiOptions
  def generate_api_options(api_call)
    api_call.reduce({}) { |options, type| options.update(type.value => type.id) }
  end
end
