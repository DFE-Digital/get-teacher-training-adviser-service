class Identity
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email_address, :string
  attribute :first_name, :string
  attribute :last_name, :string
  
end