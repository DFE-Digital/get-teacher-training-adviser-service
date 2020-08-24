class TelephoneValidator < ActiveModel::EachValidator
  TELEPHONE_FORMAT = %r{\A[^a-zA-Z]+\z}.freeze
  MINIMUM_LENGTH = 6
  MAXIMUM_LENGTH = 20

  def validate_each(record, attribute, value)
    return if value.blank?

    record.errors.add(attribute, "Enter a telephone number in the correct format") if invalid_format?(value)
    record.errors.add(attribute, "Telephone number is too short (minimum is 5 characters)") if too_short?(value)
    record.errors.add(attribute, "Telephone number is too long (maximum is 20 characters)") if too_long?(value)
  end

private

  def invalid_format?(telephone)
    TELEPHONE_FORMAT !~ telephone
  end

  def too_short?(telephone)
    telephone.to_s.length < MINIMUM_LENGTH
  end

  def too_long?(telephone)
    telephone.to_s.length > MAXIMUM_LENGTH
  end
end
