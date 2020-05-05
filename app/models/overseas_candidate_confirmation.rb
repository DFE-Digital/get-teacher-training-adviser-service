class OverseasCandidateConfirmation
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email_address, :string
  attribute :telephone_number, :string
  attribute :first_name, :string 
  attribute :last_name, :string 
  attribute :returning_to_teaching, :boolean
  attribute :primary_or_secondary, :string 
  attribute :qualified_subject, :string 
  attribute :day, :integer 
  attribute :month, :integer 
  attribute :year, :integer 
  attribute :uk_or_oversea, :string 
  attribute :telephone_number, :string
  attribute :callback_date, :string #date
  attribute :callback_time, :string


  
end