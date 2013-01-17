class AppFormBuilder < ActionView::Helpers::FormBuilder
  def select(method, choices, options = {}, html_options = {})
    select_html = super(method, choices, options, html_options)
    @template.content_tag(:div, select_html, :class => "styled_select")
  end
end