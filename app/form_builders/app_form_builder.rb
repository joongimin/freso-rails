class AppFormBuilder < ActionView::Helpers::FormBuilder
  def select(method, choices, options = {}, html_options = {})
    html_options[:class] ||= ""
    html_options[:class] << " styled_input"
    select_html = super(method, choices, options, html_options)
    @template.content_tag(:div, select_html, :class => "styled select")
  end
end