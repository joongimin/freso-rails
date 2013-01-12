module UsersHelper
  def is_english_name?(first_name, last_name)
    return !first_name.nil? && !first_name.match(/^[a-zA-Z]+$/).nil? && !last_name.nil? && !last_name.match(/^[a-zA-Z]+$/).nil?
  end

  def full_name(first_name, last_name)
    if is_english_name?(first_name, last_name)
      return "#{first_name.titleize} #{last_name.titleize}"
    else
      return "#{last_name}#{first_name}"
    end
  end
end