class UkCandidateAddress
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :address_line_1, :string
  attribute :address_line_2, :string
  attribute :postcode, :string
  
end