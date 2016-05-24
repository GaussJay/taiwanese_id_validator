require "taiwanese_id_validator/twid_validator"

class TaiwaneseIdValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if skip_check?(value)

    unless TwidValidator.valid?(value, case_sensitive?)
      record.errors[attribute] << (options[:message] || "is not a valid ID")
    end
  end

  private

  def skip_check?(value)
    (options[:allow_nil].present? && value.nil?) || (options[:allow_blank].present? && value.blank?)
  end

  def case_sensitive?
    options[:case_sensitive].nil? ? true : options[:case_sensitive]
  end
end
