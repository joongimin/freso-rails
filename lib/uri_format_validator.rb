class UriFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ /^[a-z][a-z0-9]*$/i
      object.errors.add(attribute, :uri_format, options)
    end
  end
end