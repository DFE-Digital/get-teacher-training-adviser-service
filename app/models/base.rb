class Base
  include ActiveModel::Model
  include ActiveModel::Attributes
  #extend ActiveModel::Naming

  def self.step_name
    name.underscore
  end

  def step_name
    self.class.step_name
  end

  def to_partial_path
    "registrations/#{step_name}"
  end

end 