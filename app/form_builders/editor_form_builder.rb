class EditorFormBuilder < ActionView::Helpers::FormBuilder
  def radio_button(method, tag_value, options = {})
    options[:style] ||= ""
    options[:style] << " display: none;"
    label = options.delete(:label)
    html = super(method, tag_value, options)
    html += @template.content_tag(:div, @template.content_tag(:div, "", :class => "check"), :class => "radio_button #{"checked" if object[method] == tag_value}")
    html += @template.content_tag(:span, label, :class => "radio_button_title")
    @template.content_tag(:div, html, :class => "radio_button_item")
  end
end