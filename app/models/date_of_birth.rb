class DateOfBirth
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :day, :integer
  attribute :month, :integer
  attribute :year, :integer
  
end