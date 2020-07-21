class CallbacksValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    callbacks = ApiClient.send(options[:method])

    unless callbacks.map(&:start_at).include?(value)
      record.errors[attribute] << (options[:message] || "is not included in the list")
    end
  end
end
