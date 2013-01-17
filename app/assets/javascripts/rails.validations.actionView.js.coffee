window.ClientSideValidations.formBuilders['ActionView::Helpers::FormBuilder'] = {
  add: (element, settings, message) ->
    form = $(element[0].form)
    if (element.data('valid') != false && form.find("label.message[for='" + (element.attr('id')) + "']").length == 0)
      inputErrorField = $(settings.input_tag)
      if element.attr('autofocus')
        element.attr('autofocus', false)
      element.after(inputErrorField)
      element.before(inputErrorField)
      inputErrorField.find('span#input_tag').replaceWith(element)
      inputErrorField.find('label.message').attr('for', element.attr('id'))

    return form.find("label.message[for='" + (element.attr('id')) + "']").text(message)

  remove: (element, settings) ->
    form = $(element[0].form)
    errorFieldClass = $(settings.input_tag).attr('class')
    inputErrorField = element.closest("." + (errorFieldClass.replace(" ", ".")))
    if inputErrorField[0]
      inputErrorField.find("#" + (element.attr('id'))).detach()
      inputErrorField.replaceWith(element)
}