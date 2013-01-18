$.fn.pause_validation = ->
  @is_valid_back = $.fn.isValid
  $.fn.isValid = ->

$.fn.resume_validation = ->
  $.fn.isValid = @is_valid_back
  @is_valid_back = null

# Select2 Validation
window.ClientSideValidations.selectors.validate_inputs =
window.ClientSideValidations.selectors.inputs =
  ":input:not(button):not([type='submit'])[name]:enabled, .select2-container:visible ~ :input:enabled[data-validate]"

window.ClientSideValidations.formBuilders['ActionView::Helpers::FormBuilder'] =
  add: (element, settings, message) ->
    form = $(element[0].form)
    if (element.data('valid') != false && form.find("label.message[for='" + (element.attr('id')) + "']").length == 0)
      inputErrorField = $(settings.input_tag)
      if element.attr('autofocus')
        element.attr('autofocus', false)
      element.after(inputErrorField)
      inputErrorField.find('span#input_tag').replaceWith(element)
      inputErrorField.find('label.message').attr('for', element.attr('id'))
      # HACK - Disable validation temporarily, 2013.01.18 Joon
      is_valid_bak = $.fn.isValid
      $.fn.isValid = ->
      form.effect "shake", {distance: 7}, =>
        $.fn.isValid = is_valid_bak

    return form.find("label.message[for='" + (element.attr('id')) + "']").text(message)

  remove: (element, settings) ->
    form = $(element[0].form)
    errorFieldClass = $(settings.input_tag).attr('class')
    inputErrorField = element.closest("." + (errorFieldClass.replace(" ", ".")))
    if inputErrorField[0]
      inputErrorField.find("#" + (element.attr('id'))).detach()
      inputErrorField.replaceWith(element)

window.ClientSideValidations.formBuilders['AppFormBuilder'] =
  add: (element, settings, message) ->
    form = $(element[0].form)
    if (element.data('valid') != false && form.find("label.message[for='" + (element.attr('id')) + "']").length == 0)
      inputErrorField = $(settings.input_tag)
      if element.attr('autofocus')
        element.attr('autofocus', false)

      if element.hasClass("styled_input")
        input_field = element.closest(".styled")
      else
        input_field = element

      input_field.after(inputErrorField)
      inputErrorField.find('span#input_tag').replaceWith(input_field)
      inputErrorField.find('label.message').attr('for', element.attr('id'))

      # HACK - Disable validation temporarily, 2013.01.18 Joon
      is_valid_bak = $.fn.isValid
      $.fn.isValid = ->
      form.effect "shake", {distance: 7}, =>
        $.fn.isValid = is_valid_bak

    return form.find("label.message[for='" + (element.attr('id')) + "']").text(message)

  remove: (element, settings) ->
    form = $(element[0].form)
    errorFieldClass = $(settings.input_tag).attr('class')
    inputErrorField = element.closest("." + (errorFieldClass.replace(" ", ".")))
    if inputErrorField[0]
      if element.hasClass("styled_input")
        inputErrorField.replaceWith(element.closest(".styled"))
      else
        inputErrorField.replaceWith(element)