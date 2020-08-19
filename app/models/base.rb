class Base
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations::Callbacks

  def step_name
    model_name.name.underscore
  end

  def to_partial_path
    "registrations/#{step_name}"
  end

  def save!(store)
    store.merge!(attributes)
  end
end
