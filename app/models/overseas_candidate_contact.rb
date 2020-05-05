class OverseasCandidateContact
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email_address, :string
  attribute :telephone_number, :string
  attribute :callback_date, :string #date
  attribute :callback_time, :string #date
  
end