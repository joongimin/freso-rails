window.ClientSideValidations.formBuilders['ActionView::Helpers::FormBuilder'] = {
  add: function(element, settings, message) {
    var form, inputErrorField;
    form = $(element[0].form);
    if (element.data('valid') !== false && !(form.find("label.message[for='" + (element.attr('id')) + "']")[0] != null)) {
      inputErrorField = $(settings.input_tag);
      if (element.attr('autofocus')) {
        element.attr('autofocus', false);
      }
      element.before(inputErrorField);
      inputErrorField.find('span#input_tag').replaceWith(element);
      inputErrorField.find('label.message').attr('for', element.attr('id'));
    }
    return form.find("label.message[for='" + (element.attr('id')) + "']").text(message);
  },
  remove: function(element, settings) {
    var errorFieldClass, form, inputErrorField, label;
    form = $(element[0].form);
    errorFieldClass = $(settings.input_tag).attr('class');
    inputErrorField = element.closest("." + (errorFieldClass.replace(" ", ".")));
    if (inputErrorField[0]) {
      inputErrorField.find("#" + (element.attr('id'))).detach();
      inputErrorField.replaceWith(element);
    }
  }
};