class EmailFormatValidator < ActiveModel::EachValidator
  EMAIL_WITH_FULLY_QUALIFIED_HOSTNAME = %r{\A[^\s@]+@[^.\s]+\.[^\s]+\z}.freeze
  MAXIMUM_LENGTH = 100 # As specified by the CRM

  def validate_each(record, attribute, value)
    return if value.blank?

    invalid_format = !is_an_email_uri?(value) || !is_fqdn?(value)

    if invalid_format
      record.errors.add(attribute, :invalid)
    elsif too_long?(value)
      record.errors.add(attribute, :too_long)
    end
  end

private

  def is_an_email_uri?(value)
    value.to_s.match?(URI::MailTo::EMAIL_REGEXP)
  end

  def is_fqdn?(value)
    value.to_s.match?(EMAIL_WITH_FULLY_QUALIFIED_HOSTNAME)
  end

  def too_long?(value)
    value.to_s.length > MAXIMUM_LENGTH
  end
end
