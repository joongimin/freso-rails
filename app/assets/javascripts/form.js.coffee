$ ->
  $(document).delegate "form .button.reset", "click", ->
    if confirm(I18n.t("javascripts.form.reset_confirmation"))
      $form = $(this).closest("form")
      $form[0].reset()
      $form.resetClientSideValidations()